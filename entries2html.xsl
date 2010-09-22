<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>

<xsl:template match="/">

<html>
<fieldset class="toc">
  <legend>Contents</legend>
  <ul class="toc-list">
  	<xsl:for-each select="//entry">
  		<xsl:variable name="entry-name" select="@name" />
  		<li>
  			<a href="#{concat(@name,position())}">
				<xsl:value-of select="@name" /><xsl:if test="@type='method'">(<xsl:if test="signature/argument"><xsl:text> </xsl:text>
					<xsl:for-each select="signature[1]/argument">
						<xsl:if test="position() &gt; 1">
							<xsl:text>, </xsl:text>
						</xsl:if>
						<xsl:if test="@optional">[ </xsl:if>
	  						<xsl:value-of select="@name" />
						<xsl:if test="@optional"> ]</xsl:if>
	  				</xsl:for-each>
				<xsl:text> </xsl:text></xsl:if>)</xsl:if>
  				<xsl:text> </xsl:text>
  				<span class="desc">
  					<xsl:value-of select="desc" />
  				</span>
  			</a>
			<xsl:if test="@type='method'">
	  			<ul>
	  				<xsl:for-each select="signature">
	  					<li>
	  						<a>
	  							<xsl:attribute name="href">
									#<xsl:value-of select="$entry-name" />
	  								<xsl:for-each select="argument">
          					  <xsl:variable name="argument-name" select="@name" />
          						<xsl:text>-</xsl:text><xsl:value-of select="translate($argument-name, ')(', '')"/>
	  								</xsl:for-each>
	  							</xsl:attribute>
	  							<xsl:if test="not(contains($entry-name, '.'))">.</xsl:if><xsl:value-of select="$entry-name" />(<xsl:if test="argument"><xsl:text> </xsl:text>
	  								<xsl:for-each select="argument">
	  									<xsl:if test="position() &gt; 1">
	  										<xsl:text>, </xsl:text>
	  									</xsl:if>
										<xsl:if test="@optional">[ </xsl:if>
	  									<xsl:value-of select="@name" />
										<xsl:if test="@optional"> ]</xsl:if>
	  								</xsl:for-each><xsl:text> </xsl:text></xsl:if>)
	  						</a>
	  					</li>
	  				</xsl:for-each>
	  			</ul>
			</xsl:if>
  		</li>
  	</xsl:for-each>
  </ul>
</fieldset>

<xsl:for-each select="//entry">
<xsl:variable name="entry-name" select="@name" />
<xsl:variable name="entry-type" select="@type" />
<xsl:variable name="entry-index" select="position()" />
<xsl:variable name="number-examples" select="count(example)" />
<div class="entry {@type}" id="{concat(@name,position())}">
	<h2>
		<span class="name"><xsl:value-of select="@name" /><xsl:if test="@type='method'">(<xsl:if test="signature/argument"><xsl:text> </xsl:text>
					<xsl:for-each select="signature[1]/argument">
						<xsl:if test="position() &gt; 1">
							<xsl:text>, </xsl:text>
						</xsl:if>
						<xsl:if test="@optional">[ </xsl:if>
	  						<xsl:value-of select="@name" />
						<xsl:if test="@optional"> ]</xsl:if>
	  				</xsl:for-each>
				<xsl:text> </xsl:text></xsl:if>)</xsl:if></span>
		<xsl:text> </xsl:text>
		<span class="desc"><xsl:value-of select="desc" /></span>
	</h2>
  <div class="entry-details">
    <xsl:choose>
      <xsl:when test="$entry-type='selector'">
  	  </xsl:when>
      <xsl:otherwise>
      	<p class="returns">
      		Returns: <a class="return" href="/Types#{@return}"><xsl:value-of select="@return" /></a>
      	</p>
      </xsl:otherwise>
    </xsl:choose>
    <h3>Signatures:</h3>
  	<ul class="signatures">
  		<xsl:for-each select="signature">
			  <xsl:variable name="argument-name" select="@name" />
  			<li class="signature">
  				<xsl:attribute name="id">
  					<xsl:value-of select="$entry-name" />
  					<xsl:for-each select="argument">
  						<xsl:text>-</xsl:text><xsl:value-of select="translate($argument-name, ')(', '')"/>
  					</xsl:for-each>
  				</xsl:attribute>
  				<h4 class="name">
            <span class="versionAdded">version added: <xsl:value-of select="added" /></span>
  					<xsl:if test="$entry-type='method'"><xsl:if test="not(contains($entry-name, '.'))">.</xsl:if></xsl:if><xsl:value-of select="$entry-name" /><xsl:if test="$entry-type='method'">(<xsl:if test="argument"><xsl:text> </xsl:text>
  						<xsl:for-each select="argument">
  							<xsl:if test="position() &gt; 1">
  								<xsl:text>, </xsl:text>
  							</xsl:if>
  							<xsl:if test="@optional">[ </xsl:if>
    								<xsl:value-of select="@name" />
  							<xsl:if test="@optional"> ]</xsl:if>
  						</xsl:for-each>
  					<xsl:text> </xsl:text></xsl:if>)</xsl:if>
  				</h4>
				<xsl:if test="argument">
	  				<dl class="arguments">
	  					<xsl:for-each select="argument">
							<dt><xsl:value-of select="@name" /></dt>
								<dd><xsl:copy-of select="desc/text()" /></dd>
	  					</xsl:for-each>
	  				</dl>
				</xsl:if>
  			</li>
  		</xsl:for-each>
  	</ul>
  	<xsl:if test="longdesc/*">
    	<h3>Description:</h3>
    	<div class="longdesc">
    		<xsl:copy-of select="longdesc/*" />
    	</div>
    </xsl:if>
  	<xsl:if test="$number-examples &gt; 0">
   		<h3>Example<xsl:if test="$number-examples &gt; 1">s</xsl:if>:</h3>
      <div class="entry-examples">
    	<xsl:for-each select="example">
    		<h4><xsl:if test="$number-examples &gt; 1">Example: </xsl:if><span class="desc"><xsl:value-of select="desc" /></span></h4>
<pre><code>
	  <xsl:choose>
	    <xsl:when test="html">
        <xsl:attribute name="class">example demo-code</xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="class">example</xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
  &lt;style type="text/css"&gt;<xsl:copy-of select="css/text()" />&lt;/style&gt;
  &lt;script type="text/javascript" src="/scripts/jquery-1.4.js"&gt;&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
  <xsl:copy-of select="html/text()" />
&lt;script&gt;<xsl:copy-of select="code/text()" />&lt;/script&gt;

&lt;/body&gt;
&lt;/html&gt;
</code></pre>
  <xsl:if test="html">
        <h4>Demo:</h4>
        <div><xsl:choose>
    	    <xsl:when test="html">
            <xsl:attribute name="class">demo code-demo</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="class">demo</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
        </div>
  </xsl:if>
	    </xsl:for-each>
      </div>
    </xsl:if>
  </div>
</div>

</xsl:for-each>

</html>

</xsl:template>

</xsl:stylesheet>
