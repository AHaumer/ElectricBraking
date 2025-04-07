within ElectricBraking.ParameterRecords.SMPM;
record SmpmData "Standard parameters for synchronous machines"
  extends Modelica.Icons.Record;
  import Modelica.Constants.pi;
  import Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20;
  import Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper;
  import Modelica.Electrical.Machines.Thermal.convertResistance;
  parameter String MachineType="BaseData";
  parameter SI.Inertia Jr=0.29 "Rotor's moment of inertia";
  parameter SI.Inertia Js=Jr "Stator's moment of inertia";
  parameter Integer p(final min=1)=2 "Number of pole pairs";
  parameter SI.Voltage VsNominal=100 "Nominal RMS voltage per phase"
    annotation (Dialog(tab="Nominal parameters"));
  parameter SI.Voltage VsOpenCircuit=112.3 "Open-circuit RMS voltage per phase"
    annotation (Dialog(tab="Nominal parameters"));
  parameter SI.Current IsNominal=100 "Nominal RMS current per phase"
    annotation (Dialog(tab="Nominal parameters"));
  parameter SI.Frequency fsNominal=50 "Nominal frequency"
    annotation (Dialog(tab="Nominal parameters"));
  parameter SI.AngularVelocity wNominal(displayUnit="rpm")=2*pi*fsNominal/p "Nominal shaft speed"
    annotation (Dialog(tab="Nominal parameters"));
  parameter SI.Temperature TsNominal(displayUnit="degC")=293.15 "Nominal stator temperature"
    annotation (Dialog(tab="Nominal parameters"));
  parameter SI.Resistance RsNominal=convertResistance(Rs, TsRef, alpha20s, TsNominal)
    "Stator resistance at nominal temperature"
    annotation (Dialog(tab="Nominal parameters", enable=false));
  parameter SI.Resistance Rs=0.03
    "Stator resistance per phase at TsRef"
    annotation (Dialog(tab="Impedances"));
  parameter SI.Temperature TsRef(displayUnit="degC")=293.15
    "Reference temperature of stator resistance"
    annotation (Dialog(tab="Impedances"));
  parameter LinearTemperatureCoefficient20 alpha20s=0
    "Temperature coefficient of stator resistance"
    annotation (Dialog(tab="Impedances"));
  parameter SI.Inductance Ld=0.3/(2*pi*fsNominal) "d-axis inductance"
    annotation (Dialog(tab="Impedances"));
  parameter SI.Inductance Lq=Ld "d-axis inductance"
    annotation (Dialog(tab="Impedances"));
  parameter SI.Inductance L0=0.1*Ld "zero-component inductance"
    annotation (Dialog(tab="Impedances"));
  // Calculation of additonal parameters
  parameter SI.MagneticFlux psiPM=sqrt(2)*VsOpenCircuit/(2*pi*fsNominal) "Permanent magnet flux"
    annotation (Dialog(tab="Nominal parameters"));
  parameter SI.Torque tauNominal=3/2*p*psiPM*sqrt(2)*IsNominal "Nominal torque"
    annotation (Dialog(tab="Nominal parameters"));
  annotation (
    defaultComponentName="data",
    defaultComponentPrefixes="parameter",
    Documentation(info="<html>
</html>"),
    Icon(graphics={Text(
          extent={{-100,-10},{100,-40}},
          textColor={28,108,200},
          textString="%MachineType"),
                   Text(
          extent={{-100,40},{100,10}},
          textColor={28,108,200},
          textString="SMPM")}));
end SmpmData;
