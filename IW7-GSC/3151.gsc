/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3151.gsc
***************************************/

func_2371() {
  if(scripts\asm\asm::func_232E("jackal")) {
    return;
  }
  scripts\asm\asm::func_230B("jackal", "Start");
  scripts\asm\asm::func_2373("evade", func_0C4E::func_67C5);
  scripts\asm\asm::func_2373("cannons", func_0C4E::func_1EA6);
  scripts\asm\asm::func_2374("Start", func_0C4E::func_A22E, undefined, undefined, undefined, undefined, func_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("Hover_Idle", undefined, ::func_125C3, undefined);
  scripts\asm\asm::func_2374("Hover_Idle", func_0C4E::func_A3F6, undefined, undefined, undefined, undefined, func_0C4E::func_3EDE, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("Hover_To_Fly", undefined, func_0C4E::func_9EAA, "fly");
  scripts\asm\asm::func_2375("Hover_Move", undefined, func_0C4E::func_A40C, undefined);
  scripts\asm\asm::func_2375("Hover_To_Launch", undefined, func_0C4E::func_9E75, undefined);
  scripts\asm\asm::func_2375("Hover_To_Boost", undefined, func_0C4E::func_9D70, undefined);
  scripts\asm\asm::func_2374("Fly", func_0C4E::func_A3C0, undefined, undefined, undefined, undefined, func_0C4E::func_3EDE, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("Fly_To_Hover", undefined, func_0C4E::func_9EAA, "hover");
  scripts\asm\asm::func_2375("Fly_To_Hover", undefined, func_0C4E::func_9E75, undefined);
  scripts\asm\asm::func_2375("Fly_to_boost", undefined, func_0C4E::func_9D70, undefined);
  scripts\asm\asm::func_2374("Hover_To_Fly", func_0C4E::func_A3F9, undefined, undefined, undefined, undefined, func_0C4E::func_3EDF, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("Fly", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("Fly_To_Hover", func_0C4E::func_A3C2, undefined, undefined, undefined, undefined, func_0C4E::func_3EDF, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("PASS_Finished_Fly_To_Hover", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("Hover_Move", func_0C4E::func_A3F7, undefined, undefined, undefined, undefined, func_0C4E::func_3EDE, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("Hover_To_Launch", undefined, func_0C4E::func_9E75, undefined);
  scripts\asm\asm::func_2375("Hover_To_Boost", undefined, func_0C4E::func_9D70, undefined);
  scripts\asm\asm::func_2375("Hover_Idle", undefined, func_0C4E::func_C17E, undefined);
  scripts\asm\asm::func_2375("Hover_To_Fly", undefined, func_0C4E::func_9EAA, "fly");
  scripts\asm\asm::func_2374("PASS_Finished_Fly_To_Hover", scripts\asm\shared\utility::func_2B58, undefined, undefined, undefined, undefined, func_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("Hover_Idle", undefined, func_0C4E::func_C17E, undefined);
  scripts\asm\asm::func_2375("Hover_Move", undefined, func_0C4E::func_A40C, undefined);
  scripts\asm\asm::func_2374("AnimScripted", scripts\asm\shared\utility::func_2B58, undefined, undefined, undefined, undefined, func_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("Hover_Idle", undefined, func_0C4E::func_A41C, "hover");
  scripts\asm\asm::func_2375("Fly", undefined, func_0C4E::func_A41C, "fly");
  scripts\asm\asm::func_2374("Knobs", func_0F3D::func_CEA8, undefined, undefined, undefined, undefined, func_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("Hover_To_Launch", func_0C4E::func_A3FA, undefined, undefined, undefined, undefined, func_0C4E::func_3EDF, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("Launch_Idle", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("Launch_Idle", func_0C4E::func_A3FC, undefined, undefined, undefined, undefined, func_0C4E::func_3EDE, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("Launch_To_Space_Fly", undefined, func_0C4E::func_C17C, undefined);
  scripts\asm\asm::func_2374("Launch_To_Space_Fly", func_0C4E::func_A405, undefined, undefined, undefined, undefined, func_0C4E::func_3EDF, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("Fly", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("Boost", func_0C4E::func_A3C0, undefined, undefined, undefined, undefined, func_0C4E::func_3EDE, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("Boost_To_Hover", undefined, func_0C4E::func_C17B, undefined);
  scripts\asm\asm::func_2375("Boost_To_Fly", undefined, func_0C4E::func_C17B, undefined);
  scripts\asm\asm::func_2374("Hover_To_Boost", func_0C4E::func_A3F8, undefined, undefined, undefined, undefined, func_0C4E::func_3EDF, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("Boost", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("Boost_To_Hover", func_0C4E::func_A3B1, undefined, undefined, undefined, undefined, func_0C4E::func_3EDF, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("PASS_Finished_Boost_To_Hover", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("PASS_Finished_Boost_To_Hover", scripts\asm\shared\utility::func_2B58, undefined, undefined, undefined, undefined, func_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("Hover_Idle", undefined, func_0C4E::func_C17E, undefined);
  scripts\asm\asm::func_2375("Hover_Move", undefined, func_0C4E::func_A40C, undefined);
  scripts\asm\asm::func_2374("Boost_To_Fly", func_0C4E::func_A3B0, undefined, undefined, undefined, undefined, func_0C4E::func_3EDF, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("Fly", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("Fly_to_boost", func_0C4E::func_A3C1, undefined, undefined, undefined, undefined, func_0C4E::func_3EDF, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("Boost", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("cannon_state", func_0F3D::func_CEA8, undefined, undefined, undefined, undefined, func_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2327();
}

func_125C3(var_0, var_1, var_2, var_3) {
  return 1;
}