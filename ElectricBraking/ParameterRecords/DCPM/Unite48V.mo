within ElectricBraking.ParameterRecords.DCPM;
record Unite48V "Unite 48V"
  import Modelica.Constants.pi;
  import Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper;
  extends ElectricBraking.ParameterRecords.DCPM.DcpmData(
    MachineType="Unite 48V",
    Jr=0.0012,
    Js=4*Jr,
    VaNominal=48,
    IaNominal=20,
    wNominal=3150*2*pi/60,
    TaNominal=368.15,
    Ra=0.23184,
    TaRef=293.15,
    alpha20a=alpha20Copper,
    La=0.60e-3);
  annotation (
    defaultComponentName="data",
    defaultComponentPrefixes="parameter",
    Documentation(info="<html>
</html>"));
end Unite48V;
