within ElectricBraking.Examples.Rotational;
model MechanicalBraking "Friction brake"
  extends ElectricBraking.BaseModels.RotationalExampleTemplate;
  parameter SI.Torque tau_max=40 "Max. braking torque";
  parameter SI.Force fn_max=100 "Max. brake operation force";
  parameter Real cgeo=tau_max/(brake.mu_pos[1,2]*fn_max);
  Modelica.Mechanics.Rotational.Components.Brake brake(
    mu_pos=[0,0.4],                                    cgeo=cgeo,
                                                       fn_max=fn_max,
    useHeatPort=true)
    annotation (Placement(transformation(extent={{10,-20},{-10,0}})));
  Modelica.Blocks.Sources.Step f_normalized(
    height=1,
    offset=0,
    startTime=0.1)
    annotation (Placement(transformation(extent={{30,10},{10,30}})));
equation
  connect(f_normalized.y, brake.f_normalized)
    annotation (Line(points={{9,20},{0,20},{0,1}},   color={0,0,127}));
  connect(brake.heatPort, heatFlowSensor.port_a) annotation (Line(points={{10,
          -20},{10,-30},{-40,-30},{-40,-40}}, color={191,0,0}));
  connect(brake.flange_a, inertiaLoad.flange_a)
    annotation (Line(points={{10,-10},{20,-10}}, color={0,0,0}));
  annotation (experiment(
      StopTime=5,
      Interval=1e-04,
      Tolerance=1e-06));
end MechanicalBraking;
