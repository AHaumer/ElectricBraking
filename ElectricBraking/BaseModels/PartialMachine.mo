within ElectricBraking.BaseModels;
partial model PartialMachine "Partial machine model"
  extends Modelica.Electrical.Machines.Icons.TransientMachine;
  parameter Boolean QuasiStatic=false "Ignore electrical transients?"
   annotation (Evaluate=true, choices(checkBox=true));
  extends ElectricBraking.BaseModels.ConditionalSupport;
  extends Modelica.Electrical.Analog.Interfaces.PartialConditionalHeatPort;
  SI.AngularVelocity w(start=0, displayUnit="rpm")=der(phi) "Mechanical shaft speed";
  SI.Angle phi(start=0)=shaft.phi - internalSupport.phi "Mechnical shaft angle";
  SI.Torque tau=inertiaRotor.flange_a.tau "Inner torque";
  Modelica.Mechanics.Rotational.Components.Inertia inertiaRotor
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaStator
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={40,-20})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  connect(inertiaStator.flange_b, internalSupport)
    annotation (Line(points={{50,-20},{60,-20},{60,-80}},
                                               color={0,0,0}));
  connect(inertiaRotor.flange_b, shaft)
    annotation (Line(points={{50,0},{100,0}}, color={0,0,0}));
  annotation (Icon(graphics={Line(points={{-60,90},{-60,80},{-20,80},{-20,70}},
            color={28,108,200}), Line(points={{60,90},{60,80},{20,80},{20,70}},
            color={28,108,200}),
        Text(
          extent={{-120,-120},{120,-140}},
          textColor={28,108,200},
          textString="%name")}), Documentation(info="<html>
<p>
This partial model provides mechanical parts common to all electric machines:
</p>
<ul>
<li>inertia of rotor</li>
<li>shaft flange</li>
<li>inertia of stator</li>
<li>internal support/housing flange</li>
<li>conditional mechanical fixation</li>
<li>conditional external support/housing flange</li>
</ul>
<p>
Furthermore thermal parts common to all electric machines are implemented:
</p>
<ul>
<li>internal (single) heatport</li>
<li>conditional thermal source with fixed temperature</li>
<li>conditional external thermal connector</li>
</ul>
</html>"));
end PartialMachine;
