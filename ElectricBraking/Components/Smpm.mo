within ElectricBraking.Components;
model Smpm "Permanent magnet excited synchronous machine"
  constant Integer m=3 "Number of phases";
  replaceable parameter ParameterRecords.SMPM.SmpmData data constrainedby
    ElectricBraking.ParameterRecords.SMPM.SmpmData annotation (
      choicesAllMatching=true, Placement(transformation(extent={{-90,70},{-70,
            90}})));
  extends ElectricBraking.BaseModels.PartialMachine(
    inertiaRotor(J=data.Jr),
    inertiaStator(J=data.Js),
    T=data.TsNominal);
  SI.Voltage vd=clarkeParkConverter.vdq[1] "d-axis voltage";
  SI.Voltage vq=clarkeParkConverter.vdq[2] "q-axis voltage";
  SI.Current id(start=0)=clarkeParkConverter.idq[1] "d-axis current";
  SI.Current iq(start=0)=clarkeParkConverter.idq[2] "q-axis current";
  SI.Current i0(start=0)=clarkeParkConverter.i0 "zero component current";
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug plug_p
    annotation (Placement(transformation(extent={{50,110},{70,90}})));
  Modelica.Electrical.Polyphase.Interfaces.NegativePlug plug_n
    annotation (Placement(transformation(extent={{-70,110},{-50,90}})));
  ClarkeParkConverter clarkeParkConverter(
    QuasiStatic=QuasiStatic,
    Ld=data.Ld,
    Lq=data.Lq,
    L0=data.L0,
    psiPM=data.psiPM,
    p=data.p,
    useSupport=true)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Electrical.Polyphase.Basic.Resistor statorResistance(
    m=m,
    R=fill(data.Rs, m),
    T_ref=fill(data.TsRef, m),
    alpha=fill(data.alpha20s, m),
    useHeatPort=true) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={60,60})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(m=
        m) annotation (Placement(transformation(extent={{70,40},{90,60}})));
equation
  connect(clarkeParkConverter.flange, inertiaRotor.flange_a)
    annotation (Line(points={{10,0},{30,0}}, color={0,0,0}));
  connect(clarkeParkConverter.support, inertiaStator.flange_a)
    annotation (Line(points={{0,-10},{0,-20},{30,-20}}, color={0,0,0}));
  connect(plug_p, statorResistance.plug_p)
    annotation (Line(points={{60,100},{60,70}}, color={0,0,255}));
  connect(statorResistance.plug_n, clarkeParkConverter.plug_p)
    annotation (Line(points={{60,50},{60,30},{0,30},{0,10}}, color={0,0,255}));
  connect(clarkeParkConverter.plug_n, plug_n) annotation (Line(points={{-10,0},{
          -20,0},{-20,30},{-60,30},{-60,100}}, color={0,0,255}));
  connect(statorResistance.heatPort, thermalCollector.port_a)
    annotation (Line(points={{70,60},{80,60}}, color={191,0,0}));
  connect(thermalCollector.port_b, internalHeatPort) annotation (Line(points={{80,
          40},{80,-60},{0,-60},{0,-80}}, color={191,0,0}));
  annotation (Icon(graphics={Line(points={{-60,90},{-60,80},{-20,80},{-20,70}},
            color={28,108,200}), Line(points={{60,90},{60,80},{20,80},{20,70}},
            color={28,108,200})}), Documentation(info="<html>
<p>
This is a simplified model of a permanent magnet excited synchronous machine. 
All losses except ohmic losses of the stator windings are neglected. 
The stator resistances are dependent on temperature. 
Induced voltage and generated torque are calculated in the electro-mechanical Clarke-Park converter. 
By extending from the PartialMachine, shaft flange, inertia of stator and rotor as well as 
a conditional support/housing flange and a conditional thermal connector are inherited.
</p>
</html>"));
end Smpm;
