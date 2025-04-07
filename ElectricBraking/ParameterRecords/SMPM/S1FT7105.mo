within ElectricBraking.ParameterRecords.SMPM;
record S1FT7105 "S1FT7105"
  import Modelica.Constants.pi;
  import Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper;
  extends ElectricBraking.ParameterRecords.SMPM.SmpmData(
    MachineType="S1FT7105",
    Jr=0.018,
    Js=4*Jr,
    p=5,
    VsNominal=400/sqrt(3),
    VsOpenCircuit=173/sqrt(3)*2000/1000,
    IsNominal=15,
    fsNominal=2000*p/60,
    TsNominal=368.15,
    Rs=0.15,
    TsRef=293.15,
    alpha20s=alpha20Copper,
    Ld=4.2e-3,
    Lq=Ld,
    L0=0.1*Ld);
  annotation (
    defaultComponentName="data",
    defaultComponentPrefixes="parameter",
    Documentation(info="<html>
</html>"));
end S1FT7105;
