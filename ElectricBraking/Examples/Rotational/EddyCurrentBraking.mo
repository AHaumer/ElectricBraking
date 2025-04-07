within ElectricBraking.Examples.Rotational;
model EddyCurrentBraking "EddyCurrent brake"
  extends ElectricBraking.BaseModels.RotationalExampleTemplate;
  import Modelica.Constants.pi;
  parameter SI.Torque tau_max=40 "Nominal braking torque";
  parameter SI.AngularVelocity w_max(displayUnit="rpm")=2*pi*1000/60 "Max. braking speed";
  Modelica.Mechanics.Rotational.Sources.EddyCurrentTorque
                                                 eddyCurrentTorque(
    tau_nominal=tau_max,
    w_nominal=w_max,
    TRef=293.15,
    alpha20(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper,
    useHeatPort=true)
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
equation
  connect(eddyCurrentTorque.flange, inertiaLoad.flange_a)
    annotation (Line(points={{10,-10},{20,-10}},
                                             color={0,0,0}));
  connect(eddyCurrentTorque.heatPort, heatFlowSensor.port_a) annotation (Line(
        points={{-10,-20},{-10,-30},{-40,-30},{-40,-40}}, color={191,0,0}));
  annotation (experiment(
      StopTime=10,
      Interval=1e-04,
      Tolerance=1e-06));
end EddyCurrentBraking;
