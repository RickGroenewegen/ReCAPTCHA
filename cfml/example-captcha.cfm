<cfscript>
/**
 * Sample CFML code to use reCAPTCHA V2.
 *
 * @copyright Copyright (c) 2014, Stephen J. Withington, Jr.
 * @link      https://github.com/stevewithington/ReCAPTCHA
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

// Register API keys at https://www.google.com/recaptcha/admin
siteKey = '';
secret = '';

// ReCAPTCHA supports 40+ languages listed at: https://developers.google.com/recaptcha/docs/language
lang = 'en';

// The response from ReCAPTCHA
if ( StructKeyExists(form, 'g-recaptcha-response') ) {
  reCaptcha = new recaptcha(secret);
  resp = reCaptcha.verifyResponse(response=form['g-recaptcha-response'], remoteip=cgi.remote_addr);
}

</cfscript>

<cfoutput>
  <html>
    <head>
      <title>ReCAPTCHA Example</title>
    </head>
    <body>

      <!--- Form --->
      <div>
        <form action="?" method="post">
          <div class="g-recaptcha" data-sitekey="#siteKey#"></div>
          <script type="text/javascript" src="https://www.google.com/recaptcha/api.js?hl=#lang#"></script>
          <br/>
          <input type="submit" value="submit" />
        </form>
      </div>

      <!--- Response --->
      <cfif IsDefined('resp')>
        <div>

          <cfif resp.success>

            <h3>Congratulations!</h3>
            <p>The form response is valid!</p>

          <cfelse>

            <h3>We're sorry...</h3>
            <p>The form response is invalid. Please review the entire response below:</p>

            <!--- Response --->
            <cfdump var="#resp#" label="recaptchaResponse" />

          </cfif>
        </div>
      </cfif>

    </body>
  </html>
</cfoutput>