within ElectricBraking.Examples.Translational;
model SMPMBrakingRectifier "SMPM braking an inertia"
  extends ElectricBraking.BaseModels.TranslationalExampleTemplate;
  import Modelica.Constants.pi;
  import Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper;
  constant Integer m = 3 "Number of phases";
  constant Real y2dc=2*sin(pi/3)*sqrt(2)*sin(pi/6)/(pi/6) "Factor DC&AC voltage";
  parameter SI.Resistance Rb=2*smpm.data.Rs "AC braking resistance";
  parameter SI.Resistance RbDC=Rb*y2dc^2/3 "Equivalent DC braking resistance";
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-30,-20},{-10,0}})));
  Modelica.Electrical.Analog.Basic.Resistor    brakingResistor(each R=RbDC,
    T_ref=293.15,
    alpha=alpha20Copper,
    useHeatPort=true)
                     annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-10,50})));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch    switch(Ron=1e-5,
      Goff=1e-5)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=270,
        origin={10,50})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=0.1)
    annotation (Placement(transformation(extent={{50,40},{30,60}})));
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(m=m,
      terminalConnection="Y")
    annotation (Placement(transformation(extent={{-10,-4},{10,16}})));
  Components.Smpm smpm(
    redeclare ElectricBraking.ParameterRecords.SMPM.S1FT7102 data,
    QuasiStatic=false,
    useHeatPort=true,
    id(fixed=true, start=0),
    iq(fixed=true, start=0),
    i0(start=0, fixed=true))
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  Modelica.Electrical.PowerConverters.ACDC.DiodeBridge2mPulse rectifier(
    m = m, VkneeDiode = 1e-3) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={0,20})));
  Modelica.Electrical.Analog.Basic.Resistor earthing(each R=1e6,
      useHeatPort=false) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-20,20})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,70})));
  Modelica.Mechanics.Translational.Components.IdealGearR2T
    idealGearR2T(ratio=1/experimentSettings.r)
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
equation
  connect(ground.p, terminalBox.starpoint)
    annotation (Line(points={{-20,0},{-20,2},{-10,2}},    color={0,0,255}));
  connect(terminalBox.plug_sn, smpm.plug_n)
    annotation (Line(points={{-6,0},{-6,0}},   color={0,0,255}));
  connect(terminalBox.plug_sp, smpm.plug_p)
    annotation (Line(points={{6,0},{6,0}},   color={0,0,255}));
  connect(rectifier.dc_p, switch.p)
    annotation (Line(points={{6,30},{6,40},{10,40}}, color={0,0,255}));
  connect(brakingResistor.n, rectifier.dc_n) annotation (Line(points={{-10,40},
          {-6,40},{-6,30}},              color={0,0,255}));
  connect(booleanStep.y, switch.control)
    annotation (Line(points={{29,50},{22,50}}, color={255,0,255}));
  connect(earthing.n, ground.p)
    annotation (Line(points={{-20,10},{-20,0}},  color={0,0,255}));
  connect(rectifier.ac, terminalBox.plugSupply)
    annotation (Line(points={{0,10},{0,2}}, color={0,0,255}));
  connect(currentSensor.p, switch.n)
    annotation (Line(points={{10,70},{10,60}}, color={0,0,255}));
  connect(currentSensor.n, brakingResistor.p)
    annotation (Line(points={{-10,70},{-10,60}}, color={0,0,255}));
  connect(rectifier.dc_n, earthing.p) annotation (Line(points={{-6,30},{-6,
          40},{-20,40},{-20,30}}, color={0,0,255}));
  connect(smpm.heatPort, heatFlowSensor.port_a) annotation (Line(points={{0,-20},
          {0,-30},{-40,-30},{-40,-40}}, color={191,0,0}));
  connect(brakingResistor.heatPort, heatFlowSensor.port_a)
    annotation (Line(points={{-20,50},{-40,50},{-40,-40}}, color={191,0,0}));
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
The induced voltages (by the permanent magnets) are rectified (by a diode rectifier).
Subsequently a switch is closed and the induced voltages drive the stator currents 
through stator resistances and stator inductances out of the machine and through the recticier, and through the external braking resistance. 
The internal and external losses are fed to a thermal capacitance, that increases the temperature. 
The amount of dissipated heat is equivalent to the kinetic energy of internal and external inertia.
</p>
</html>"));
end SMPMBrakingRectifier;
