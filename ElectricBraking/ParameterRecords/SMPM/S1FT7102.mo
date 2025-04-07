within ElectricBraking.ParameterRecords.SMPM;
record S1FT7102 "S1FT7102"
  import Modelica.Constants.pi;
  import Modelica.Electrical.Machines.Thermal.Constants.alpha20Copper;
  extends ElectricBraking.ParameterRecords.SMPM.SmpmData(
    MachineType="S1FT7102",
    Jr=0.009,
    Js=4*Jr,
    p=5,
    VsNominal=400/sqrt(3),
    VsOpenCircuit=212.3/sqrt(3)*1500/1000,
    IsNominal=8,
    fsNominal=1500*p/60,
    TsNominal=368.15,
    Rs=0.6,
    TsRef=293.15,
    alpha20s=alpha20Copper,
    Ld=12.5e-3,
    Lq=Ld,
    L0=0.1*Ld);
  annotation (
    defaultComponentName="data",
    defaultComponentPrefixes="parameter",
    Documentation(info="<html>
</html>"));
end S1FT7102;
