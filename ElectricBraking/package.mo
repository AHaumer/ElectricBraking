within ;
package ElectricBraking "Electric braking using electric machines"
  extends Modelica.Icons.Package;
  import Modelica.Units.SI;

  annotation (version="1.0.0",
    versionDate="2025-04-06",
    uses(Modelica(version="4.0.0")),
    preferredView="info",
    Documentation(info="<html>
<p>
This library demonstrates braking using electric machines electrically loaded by resistors. 
Note that the machine models are simplified, only taking resistive losses into account. 
Equations and parameters are shortly explained in <a href=\"modelica://ElectricBraking/Resources/Documents/ElectricBraking.pdf\">this document</a>.
</p>
<h4>Copyright and License (BSD 3-Clause)</h4>
<p>
&copy; 2025 Prof. Anton Haumer <a HREF=\"https://www.oth-regensburg.de/en/faculties/electrical-engineering-and-information-technology.html\">
OTH Regensburg, Faculty of Electrical Engineering and Information Technology</a>
</p>
<p>
Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
</p>
<ol>
<li>Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.</li>
<li>Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation 
    and/or other materials provided with the distribution.</li>
<li>Neither the name of the <organization> nor the names of its contributors may be used to endorse or promote products
    derived from this software without specific prior written permission.</li>
</ol>
<p>
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS \"AS IS\" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, 
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES 
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
</p>
</html>"));
end ElectricBraking;
