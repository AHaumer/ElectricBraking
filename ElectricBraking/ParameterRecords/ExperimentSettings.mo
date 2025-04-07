within ElectricBraking.ParameterRecords;
record ExperimentSettings "Experiment settings"
  extends Modelica.Icons.Record;
  import Modelica.Constants.pi;
  parameter SI.Inertia JL=1 "Load inertia";
  parameter SI.AngularVelocity w0(displayUnit="rpm")=2*pi*1500/60 "Initial rotational speed";
  parameter SI.Length r=0.2 "Radius of rotational-translational coupling";
  parameter SI.Mass mL=JL/r^2 "Load mass";
  parameter SI.Velocity v0=w0*r "Initial translational speed";
  parameter SI.Energy Ekin=JL*w0^2/2 "Initial kinetic energy";
  parameter SI.TemperatureDifference dT=40 "Temperature rise during one braking process";
  parameter SI.HeatCapacity Ctherm=Ekin/dT "Thermal capacitance";
  annotation (defaultComponentPrefixes="parameter");
end ExperimentSettings;
