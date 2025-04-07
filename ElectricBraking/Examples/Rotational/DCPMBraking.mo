within ElectricBraking.Examples.Rotational;
model DCPMBraking "DCPM braking an inertia"
  extends ElectricBraking.BaseModels.RotationalExampleTemplate;
  import Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper;
  parameter SI.Resistance Rb=dcpm.data.ViNominal/(2*dcpm.data.IaNominal) - dcpm.data.RaNominal "Braking resistance";
  Components.Dcpm dcpm(
    redeclare ElectricBraking.ParameterRecords.DCPM.UniteXL data,
    QuasiStatic=false,
    useHeatPort=true,
    ia(fixed=true, start=0))
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  Modelica.Electrical.Analog.Basic.Ground ground
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-20,-10})));
  Modelica.Electrical.Analog.Basic.Resistor brakingResistor(R=Rb,
    T_ref=293.15,
    alpha=alpha20Copper,                                          useHeatPort=true)
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-10,20})));
  Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=270,
        origin={10,20})));
  Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=0.1)
    annotation (Placement(transformation(extent={{50,10},{30,30}})));
  Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,40})));
equation
  connect(ground.p, dcpm.pin_n)
    annotation (Line(points={{-20,0},{-6,0}},   color={0,0,255}));
  connect(dcpm.pin_p, switch.p)
    annotation (Line(points={{6,0},{6,10},{10,10}},          color={0,0,255}));
  connect(booleanStep.y, switch.control)
    annotation (Line(points={{29,20},{22,20}},        color={255,0,255}));
  connect(brakingResistor.p, currentSensor.n)
    annotation (Line(points={{-10,30},{-10,40}},color={0,0,255}));
  connect(currentSensor.p, switch.n)
    annotation (Line(points={{10,40},{10,30}}, color={0,0,255}));
  connect(brakingResistor.n, dcpm.pin_n)
    annotation (Line(points={{-10,10},{-6,10},{-6,0}}, color={0,0,255}));
  connect(dcpm.shaft, inertiaLoad.flange_a)
    annotation (Line(points={{10,-10},{20,-10}}, color={0,0,0}));
  connect(dcpm.heatPort, heatFlowSensor.port_a) annotation (Line(points={{0,-20},
          {0,-30},{-40,-30},{-40,-40}}, color={191,0,0}));
  connect(heatFlowSensor.port_a, brakingResistor.heatPort)
    annotation (Line(points={{-40,-40},{-40,20},{-20,20}}, color={191,0,0}));
  annotation (experiment(
      StopTime=10,
      Interval=1e-04,
      Tolerance=1e-06),
    Documentation(info="<html>
<p>
A DC machine mechanically connected with a load inertia is initialized at nominal speed. 
Subsequently a switch is closed and the induced voltage (by the permanent magnets) drives the armature current 
through armature resistance and armature inductance out of the machine and through the external braking resistance. 
The internal and external losses are fed to a thermal capacitance, that increases the temperature. 
The amount of dissipated heat is equivalent to the kinetic energy of internal and external inertia.
</p>
</html>"));
end DCPMBraking;
