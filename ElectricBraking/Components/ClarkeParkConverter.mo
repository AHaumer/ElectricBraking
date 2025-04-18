within ElectricBraking.Components;
model ClarkeParkConverter "Converter between electrical threephase and mechanical domian"
  constant Integer m=3 "Number of phases";
  parameter Boolean QuasiStatic=false "Ignore electrical transients?"
   annotation (Evaluate=true);
  parameter SI.Inductance Ld "d-axis inductance";
  parameter SI.Inductance Lq "q-axis inductance";
  parameter SI.Inductance L0 "zero component inductance";
  parameter SI.MagneticFlux psiPM "Permanent magnet flux";
  parameter Integer p(final min=1) "Number of pole pairts";
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plug_p(m=m)
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug plug_n(m=m)
    annotation (Placement(transformation(extent={{-110,10},{-90,-10}})));
  SI.Voltage vS[m]=plug_p.pin.v - plug_n.pin.v "Stator voltages";
  SI.Current iS[m]=plug_p.pin.i "Stator currents";
  SI.Voltage vdq[2] "Voltage space phasor in d,q-frame";
  SI.Current idq[2] "Current space phasor in d,q-frame";
  SI.Voltage v0=sum(vS)/m "Zero voltage component";
  SI.Current i0=sum(iS)/m "Zero current component";
  extends Modelica.Mechanics.Rotational.Interfaces.PartialElementaryOneFlangeAndSupport2;
  SI.Angle phi_m=flange.phi - phi_support "(Relative) shaft angle";
  SI.AngularVelocity w_m(displayUnit="rpm")=der(phi_m) "(Relative) shaft speed";
  SI.Torque tau=-flange.tau "Torque out of the component";
protected
  parameter SI.Angle phi[m]=Modelica.Electrical.Polyphase.Functions.symmetricOrientation(m);
  parameter Real TransformationMatrix[2, m]=2/m*{+cos(+phi),+sin(+phi)};
  Real RotationMatrix[2, 2]={{+cos(p*phi_m),-sin(p*phi_m)},{+sin(p*phi_m),+cos(p*phi_m)}};
equation
  plug_p.pin.i + plug_n.pin.i = zeros(m) "Current balance";
  //Clarke-Park-Transform
  RotationMatrix*vdq=TransformationMatrix*vS;
  RotationMatrix*idq=TransformationMatrix*iS;
  // Voltages in d/q-frame
  vdq[1]= Ld*der(idq[1])*(if QuasiStatic then 1e-5 else 1) - p*w_m*Lq*idq[2];
  vdq[2]= Lq*der(idq[2])*(if QuasiStatic then 1e-5 else 1) + p*w_m*Ld*idq[1] + p*w_m*psiPM;
  v0=L0*der(i0);
  // Torque
  tau=m/2*p*(psiPM + (Ld - Lq)*idq[1])*idq[2];
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-10,-38},{10,-86}},
          lineColor={175,175,175},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{34,10},{100,-10}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.HorizontalCylinder),
        Text(
          textColor={0,0,255},
          extent={{-150,-80},{150,-40}},
          textString="%name"),
        Ellipse(
          extent={{-36,36},{36,-36}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{0,90},{0,0},{-90,0}},
                                      color={0,0,255})}),        Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>
This electro-mechanical converter converts the pase currents and voltages to space phasors in the rotor fixed frame.
Here Kirchhoff’s voltage law for d- and q-axis are formulated, included the induced voltage due to the permanent magnets.
Additionally, a relationship between zero component voltage and current using the zero-component inductance L<sub>0</sub> is established.
Last but not least the torque generated by permanent magnets and q-current as well as the reluctance torque are calculated.
</p>
</html>"));
end ClarkeParkConverter;
