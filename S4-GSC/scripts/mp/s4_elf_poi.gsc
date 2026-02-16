/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\s4_elf_poi.gsc
*************************************************/

init() {
  if(!getdvarint("#x3837ebb0d79d89495", 0)) {
    return;
  }
  if(scripts\mp\utility\game::isanymlgmatch()) {
    return;
  }
  level.elf_animtypes = ["sitting", "standing", "laying", "s4_mp_elf_pose_hang_01", "s4_mp_elf_pose_hang_02", "s4_mp_elf_pose_hang_03", "s4_mp_elf_pose_hang_04"];

  if(!isDefined(level.s4_elf_poi_structs)) {
    level.s4_elf_poi_structs = [];
  }

  while(!istrue(level._id_60F6)) {
    waitframe();
  }

  foreach(var_1 in scripts\engine\utility::getStructArray("elf_poi", "targetname")) {
    add_elf_poi_position(var_1.origin, var_1.angles, var_1._id_039B);
  }

  level thread run_elf_spawn_loop();
}

run_elf_spawn_loop() {
  if(!isDefined(level.s4_elf_poi_structs) || level.s4_elf_poi_structs.size == 0) {
    return;
  }
  for(;;) {
    foreach(var_1 in level.s4_elf_poi_structs) {
      var_2 = var_1 run_elf_logic();

      while(isDefined(var_2) && !_func_0458(var_2)) {
        wait 0.5;
      }
    }
  }
}

add_elf_poi_position(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_0;
  var_3.angles = scripts\engine\utility::ter_op(isDefined(var_1), var_1, (0, 0, 0));
  var_3.elf_animtype = var_2;

  if(!isDefined(level.s4_elf_poi_structs)) {
    level.s4_elf_poi_structs = [var_3];
  } else {
    level.s4_elf_poi_structs = scripts\engine\utility::array_add(level.s4_elf_poi_structs, var_3);
  }
}

run_elf_logic() {
  var_0 = self;
  var_1 = "s4_mp_elf_pose_stand_01";
  var_2 = spawn("script_model", var_0.origin);
  var_2.angles = var_0.angles;
  var_2 setModel("c_s4_mp_elf_01");

  if(isDefined(var_0.elf_animtype)) {
    var_1 = getanimreffromref(var_0.elf_animtype);
  }

  if(isDefined(var_0._id_039B)) {
    var_1 = var_0._id_039B;
  }

  var_2 _meth_82CB(var_1, "elf_anim_notify");
  var_2 thread play_spawn_sound();
  var_2 thread play_spawn_sound_bells();
  var_2 thread wait_for_damage();
  return var_2;
}

wait_for_damage() {
  self setCanDamage(1);
  self waittill("damage", var_0, var_1);
  stop_elf_laugh_sound();
  playFX(scripts\engine\utility::getfx("vfx_codmas_krampus_despawn"), self.origin);
  thread play_despawn_sound_bells();

  if(isDefined(var_1) && isPlayer(var_1)) {
    var_1 thread _id_07BC::creategametypechallenegeevent("kill_elf");
  }

  self delete();
}

getanimreffromref(var_0) {
  var_1 = "s4_mp_elf_pose_stand_01";

  switch (var_0) {
    case "sitting":
      var_1 = "s4_mp_elf_pose_sitting_01";
      break;
    case "standing":
      var_1 = "s4_mp_elf_pose_stand_01";
      break;
    case "laying":
      var_1 = "s4_mp_elf_pose_prone_01";
      break;
    default:
      var_1 = var_0;
      break;
  }

  return var_1;
}

play_spawn_sound() {
  self playLoopSound("mp_elf_idle_lp");
}

stop_elf_laugh_sound() {
  self stoploopsound();
  self playSound("mp_elf_hit_defeat");
}

play_spawn_sound_bells() {
  self playSound("mp_elf_spawn");
}

play_despawn_sound_bells() {
  self playSound("mp_elf_despawn");
}