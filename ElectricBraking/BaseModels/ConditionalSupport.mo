within ElectricBraking.BaseModels;
partial model ConditionalSupport
  "Partial model for a component with a conditional support used for graphical modeling"
  parameter Boolean useSupport=false "= true, if support flange enabled"
    annotation (
    Evaluate=true,
    HideResult=true,
    choices(checkBox=true));
  Modelica.Mechanics.Rotational.Interfaces.Support support if useSupport
    "Support/housing of component" annotation (Placement(transformation(extent={
            {50,-110},{70,-90}}), iconTransformation(extent={{50,-110},{70,-90}})));
protected
  Modelica.Mechanics.Rotational.Interfaces.Support internalSupport
    "Internal support/housing of component (either connected to support, if useSupport=true, or connected to fixed, if useSupport=false)"
    annotation (Placement(transformation(extent={{57,-83},{63,-77}})));
  Modelica.Mechanics.Rotational.Components.Fixed fixed if not useSupport
    "Fixed support/housing, if not useSupport"
    annotation (Placement(transformation(extent={{70,-94},{90,-74}})));
equation
  connect(support, internalSupport) annotation (Line(
      points={{60,-100},{60,-80}}));
  connect(internalSupport, fixed.flange) annotation (Line(
      points={{60,-80},{80,-80},{80,-84}}));
  annotation (
    Documentation(info="<html>
<p>
This is a 1-dim. rotational component with a contional support/housing.
It is used e.g., to build up parts of a drive train graphically consisting
of several components.
</p>

<p>
If <em>useSupport=true</em>, the support connector is conditionally enabled
and needs to be connected.<br>
If <em>useSupport=false</em>, the support connector is conditionally disabled
and instead the component is internally fixed to ground.
</p>
</html>"),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}})),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={Line(
              visible=not useSupport,
              points={{10,-120},{30,-100}}),  Line(
              visible=not useSupport,
              points={{30,-120},{50,-100}}),  Line(
              visible=not useSupport,
              points={{50,-120},{70,-100}}), Line(
              visible=not useSupport,
              points={{70,-120},{90,-100}}),Line(
              visible=not useSupport,
              points={{30,-100},{90,-100}})}));
end ConditionalSupport;
