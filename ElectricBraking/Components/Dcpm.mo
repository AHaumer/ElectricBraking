within ElectricBraking.Components;
model Dcpm "Permanent magnet excited dc machine"
  replaceable parameter ParameterRecords.DCPM.DcpmData data constrainedby
    ElectricBraking.ParameterRecords.DCPM.DcpmData annotation (
      choicesAllMatching=true, Placement(transformation(extent={{-90,70},{-70,
            90}})));
  extends ElectricBraking.BaseModels.PartialMachine(
    inertiaRotor(J=data.Jr),
    inertiaStator(J=data.Js),
    T=data.TaNominal);
  SI.Voltage va=pin_p.v - pin_n.v "Armature voltage";
  SI.Current ia(start=0)=pin_p.i "Armature current";
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
    annotation (Placement(transformation(extent={{50,110},{70,90}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
    annotation (Placement(transformation(extent={{-70,110},{-50,90}})));
  ElectroMechanicalConverter electroMechanicalConverter(kPhi=data.kPhi,
      useSupport=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Analog.Basic.Resistor armatureResistance(
    R=data.Ra,
    T_ref=data.TaRef,
    alpha=data.alpha20a,
    useHeatPort=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={60,60})));
  Modelica.Electrical.Analog.Basic.Inductor armatureInductance(L=data.La*(
        if QuasiStatic then 1e-5 else 1))
    annotation (Placement(transformation(extent={{40,20},{20,40}})));
equation
  connect(pin_p, armatureResistance.p)
    annotation (Line(points={{60,100},{60,70}}, color={0,0,255}));
  connect(armatureResistance.n, armatureInductance.p)
    annotation (Line(points={{60,50},{60,30},{40,30}}, color={0,0,255}));
  connect(electroMechanicalConverter.pin_p, armatureInductance.n)
    annotation (Line(points={{0,10},{0,30},{20,30}}, color={0,0,255}));
  connect(electroMechanicalConverter.pin_n, pin_n) annotation (Line(points={{-10,
          0},{-20,0},{-20,30},{-60,30},{-60,100}}, color={0,0,255}));
  connect(armatureResistance.heatPort, internalHeatPort) annotation (Line(
        points={{70,60},{80,60},{80,-60},{0,-60},{0,-80}}, color={191,0,0}));
  connect(electroMechanicalConverter.flange, inertiaRotor.flange_a)
    annotation (Line(points={{10,0},{30,0}}, color={0,0,0}));
  connect(electroMechanicalConverter.support, inertiaStator.flange_a)
    annotation (Line(points={{0,-10},{0,-20},{30,-20}}, color={0,0,0}));
  annotation (Icon(graphics={Line(points={{-60,90},{-60,80},{-20,80},{-20,70}},
            color={28,108,200}), Line(points={{60,90},{60,80},{20,80},{20,70}},
            color={28,108,200}),
        Rectangle(
          extent={{-80,40},{-60,-40}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.HorizontalCylinder),
        Line(points={{-80,-36},{-60,-36}}, color={0,0,0}),
        Line(points={{-80,-30},{-60,-30}}, color={0,0,0}),
        Line(points={{-80,-20},{-60,-20}}, color={0,0,0}),
        Line(points={{-80,-10},{-60,-10}}, color={0,0,0}),
        Line(points={{-80,0},{-60,0}}, color={0,0,0}),
        Line(points={{-80,10},{-60,10}}, color={0,0,0}),
        Line(points={{-80,20},{-60,20}}, color={0,0,0}),
        Line(points={{-80,30},{-60,30}}, color={0,0,0}),
        Line(points={{-80,36},{-60,36}}, color={0,0,0})}), Documentation(
        info="<html>
<p>
This is a simplified model of a permanent magnet excited DC machine. 
All losses except ohmic losses of the armature winding are neglected. 
The armature resistance is dependent on temperature. 
Additionally, the armature inductance is implemented. 
Induced voltage and generated torque are calculated in the electro-mechanical converter. 
By extending from the PartialMachine, shaft flange, inertia of stator and rotor as well as 
a conditional support/housing flange and a conditional thermal connector are inherited.
</p>
</html>"));
end Dcpm;
