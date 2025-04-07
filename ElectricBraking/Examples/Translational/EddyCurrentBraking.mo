within ElectricBraking.Examples.Translational;
model EddyCurrentBraking "EddyCurrent brake"
  extends ElectricBraking.BaseModels.TranslationalExampleTemplate;
  import Modelica.Constants.pi;
  parameter SI.Torque tau_max=40 "Nominal braking torque";
  parameter SI.Force f_max=tau_max/experimentSettings.r "Max. braking force";
  parameter SI.AngularVelocity w_max(displayUnit="rpm")=2*pi*1000/60 "Max. rotational braking speed";
  parameter SI.Velocity v_max=w_max*experimentSettings.r "Max. translational braking speed";
  Modelica.Mechanics.Translational.Sources.EddyCurrentForce
                                                 eddyCurrentForce(
    f_nominal=f_max,
    v_nominal=v_max,
    TRef=293.15,
    alpha20(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper,
    useHeatPort=true)
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
equation
  connect(eddyCurrentForce.heatPort, heatFlowSensor.port_a) annotation (Line(
        points={{-10,-20},{-10,-30},{-40,-30},{-40,-40}}, color={191,0,0}));
  connect(eddyCurrentForce.flange, massLoad.flange_a)
    annotation (Line(points={{10,-10},{50,-10}}, color={0,127,0}));
  annotation (experiment(
      StopTime=10,
      Interval=1e-04,
      Tolerance=1e-06));
end EddyCurrentBraking;
