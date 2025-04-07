within ElectricBraking.ParameterRecords.DCPM;
record UniteXL "UniteXL"
  import Modelica.Constants.pi;
  import Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper;
  extends ElectricBraking.ParameterRecords.DCPM.DcpmData(
    MachineType="UniteXL",
    Jr=0.012,
    Js=4*Jr,
    VaNominal=480,
    IaNominal=10,
    wNominal=1500*2*pi/60,
    TaNominal=368.15,
    Ra=2.628,
    TaRef=293.15,
    alpha20a=alpha20Copper,
    La=6.5e-3);
  annotation (
    defaultComponentName="data",
    defaultComponentPrefixes="parameter",
    Documentation(info="<html>
</html>"));
end UniteXL;
