within ElectricBraking.Examples.Translational;
model SMPMBraking "SMPM braking an inertia"
  extends ElectricBraking.BaseModels.TranslationalExampleTemplate;
  import Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper;
  constant Integer m = 3 "Number of phases";
  parameter SI.Resistance Rb=2*smpm.data.Rs "AC braking resistance";
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-20,-10})));
  Modelica.Electrical.Polyphase.Basic.Resistor brakingResistor(m=m,
    each R=fill(Rb, m),
    T_ref=fill(293.15, m),
    alpha=fill(alpha20Copper, m),
    useHeatPort=true)
                     annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-20,50})));
  Modelica.Electrical.Polyphase.Ideal.IdealClosingSwitch switch(m=m,
    Ron=fill(1e-5, m),
    Goff=fill(1e-5, m))
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=270,
        origin={0,20})));
  Modelica.Blocks.Sources.BooleanStep booleanStep[m](each startTime=0.1)
    annotation (Placement(transformation(extent={{40,10},{20,30}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(m=m,
      terminalConnection="Y")
    annotation (Placement(transformation(extent={{-10,-4},{10,16}})));
  Modelica.Electrical.Polyphase.Basic.Star star(m=m)
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,20})));
  Modelica.Electrical.Polyphase.Sensors.CurrentQuasiRMSSensor
    currentRMSSensor(m=m) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-10,70})));
  Components.Smpm smpm(
    redeclare ElectricBraking.ParameterRecords.SMPM.S1FT7102 data,
    QuasiStatic=false,
    useHeatPort=true,
    id(fixed=true, start=0),
    iq(fixed=true, start=0),
    i0(start=0, fixed=true))
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector
    thermalCollector(m=m)
    annotation (Placement(transformation(extent={{-50,22},{-30,42}})));
  Modelica.Mechanics.Translational.Components.IdealGearR2T
    idealGearR2T(ratio=1/experimentSettings.r)
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
equation
  connect(ground.p, terminalBox.starpoint)
    annotation (Line(points={{-20,0},{-20,2},{-10,2}},    color={0,0,255}));
  connect(switch.plug_p, terminalBox.plugSupply)
    annotation (Line(points={{0,10},{0,2}},  color={0,0,255}));
  connect(booleanStep.y, switch.control)
    annotation (Line(points={{19,20},{12,20}}, color={255,0,255}));
  connect(star.plug_p, brakingResistor.plug_n)
    annotation (Line(points={{-20,30},{-20,40}}, color={0,0,255}));
  connect(brakingResistor.plug_p, currentRMSSensor.plug_n)
    annotation (Line(points={{-20,60},{-20,70}},
                                               color={0,0,255}));
  connect(currentRMSSensor.plug_p, switch.plug_n)
    annotation (Line(points={{0,70},{0,30}}, color={0,0,255}));
  connect(terminalBox.plug_sn, smpm.plug_n)
    annotation (Line(points={{-6,0},{-6,0}},   color={0,0,255}));
  connect(terminalBox.plug_sp, smpm.plug_p)
    annotation (Line(points={{6,0},{6,0}},   color={0,0,255}));
  connect(brakingResistor.heatPort, thermalCollector.port_a) annotation (
      Line(points={{-30,50},{-40,50},{-40,42}}, color={191,0,0}));
  connect(smpm.heatPort, heatFlowSensor.port_a) annotation (Line(points={{0,-20},
          {0,-30},{-40,-30},{-40,-40}}, color={191,0,0}));
  connect(heatFlowSensor.port_a, thermalCollector.port_b)
    annotation (Line(points={{-40,-40},{-40,22}}, color={191,0,0}));
  connect(smpm.shaft, idealGearR2T.flangeR)
    annotation (Line(points={{10,-10},{20,-10}}, color={0,0,0}));
  connect(idealGearR2T.flangeT, massLoad.flange_a)
    annotation (Line(points={{40,-10},{50,-10}}, color={0,127,0}));
  annotation (experiment(
      StopTime=10,
      Interval=1e-04,
      Tolerance=1e-06), Documentation(info="<html>
<p>
A synchronous machine mechanically connected with a load inertia is initialized at nominal speed. 
Subsequently a switch is closed and the induced voltages (by the permanent magnets) drive the stator currents 
through stator resistances and stator inductances out of the machine and through the external braking resistances. 
The internal and external losses are fed to a thermal capacitance, that increases the temperature. 
The amount of dissipated heat is equivalent to the kinetic energy of internal and external inertia.
</p>
</html>"));
end SMPMBraking;
