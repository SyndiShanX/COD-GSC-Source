/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\ber3.csc
*****************************************************/

#include clientscripts\_utility;
#include clientscripts\_music;

resolve_struct_targets() {
  for (i = 0; i < level.struct.size; i++) {
    struct = level.struct[i];
    if(isDefined(struct.target)) {
      targ_struct = getstructarray(struct.target, "targetname");
      if(isDefined(targ_struct)) {
        struct.targeted = [];
        for (j = 0; j < targ_struct.size; j++) {
          struct.targeted[struct.targeted.size] = targ_struct[j];
        }
      }
    }
  }
}

debug_position(model) {
  while (1) {
    print3d(self.origin, " + " + model, (0.0, 1.0, 0.0), 1, 3, 30);
    realwait(1.0);
  }
}

decorate_level() {
  models = [];
  models[models.size] = "vehicle_rus_tracked_t34_dmg";
  models[models.size] = "vehicle_rus_tracked_t34_dmg";
  models[models.size] = "vehicle_rus_tracked_t34_dmg";
  models[models.size] = "vehicle_rus_tracked_t34_dmg";
  level waittill("dl");
  structs = getstructarray("coop_dest_tank_spot", "targetname");
  players = getlocalplayers();
  for (i = 0; i < structs.size; i++) {
    struct = structs[i];
    model = models[randomintrange(0, models.size)];
    for (j = 0; j < players.size; j++) {
      ent = spawn(j, structs[i].origin, "script_model");
      ent setmodel(model);
      ent.angles = structs[i].angles;
    }
  }
}

main() {
  clientscripts\_load::main();
  resolve_struct_targets();
  clientscripts\_artillery::main("artillery_ger_pak43", "pak43");
  clientscripts\_katyusha::main("vehicle_rus_wheeled_bm13");
  clientscripts\_t34::main("vehicle_rus_tracked_t34");
  clientscripts\ber3_fx::main();
  thread clientscripts\_audio::audio_init(0);
  thread clientscripts\ber3_amb::main();
  thread decorate_level();
  thread waitforclient(0);
  println("*** Client : ber3 running...");
}