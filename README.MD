# Material Import Override

Automatically overrides materials on import based on their name.

## Description

Say you've got a material set up in Blender and a hundred meshes using it. Everything looks great until you import into Godot - the material looks wrong. This is because Godot can only import very basic materials without any custom logic.

The purpose of this plugin is to allow overriding of import materials based on their name.

For example:
- You have a hundred meshes with a material called 'MyFancyMaterial'.
- You have an equivalent *M_MyOverrideMaterial* set up in Godot
- On import, any time Godot detects a mesh using 'MyFancyMaterial' it will automatically replace that material with *M_MyOverrideMaterial*

## Usage

- Drop the addon in your *addons* folder and enable it in *Project - Project Settings - Addons*
- Open */addons/material_import_override/material_importer.gd*
- Add any overrides to the exported `overrides` variable.

For example if you want to replace 'MyFancyMaterial' with your `M_MyOverrideMaterial` your `overrides` will look like so:

```gdscript
@export var overrides: Dictionary = {
	'MyFancyMaterial': "res://path/to/M_MyOverrideMaterial.tres",
}
```