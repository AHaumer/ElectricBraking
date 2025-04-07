within ElectricBraking.BaseModels;
partial model RotationalExampleTemplate
  extends Modelica.Icons.Example;
  parameter ParameterRecords.ExperimentSettings experimentSettings
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  Modelica.Mechanics.Rotational.Components.Inertia inertiaLoad(
    J=experimentSettings.JL,
    phi(fixed=true, start=0),
    w(fixed=true, start=experimentSettings.w0))
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-40,-50})));
  Modelica.Blocks.Continuous.Integrator integrator
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=
        experimentSettings.Ctherm, T(fixed=true, start=293.15))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-40,-80})));
equation
  connect(heatFlowSensor.port_b, heatCapacitor.port)
    annotation (Line(points={{-40,-60},{-40,-70}}, color={191,0,0}));
  connect(heatFlowSensor.Q_flow, integrator.u)
    annotation (Line(points={{-29,-50},{-22,-50}}, color={0,0,127}));
  annotation (experiment(
      StopTime=0.5,
      Interval=1e-04,
      Tolerance=1e-06));
end RotationalExampleTemplate;
