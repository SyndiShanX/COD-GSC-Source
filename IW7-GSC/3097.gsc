/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3097.gsc
**************************************/

func_5CC5() {
  self.var_5CC3 = spawnStruct();
  self.var_5CC3.var_1E2D = 1;
  thread func_1970();
}

func_1970() {
  self endon("terminate_ai_threads");
  self endon("death");

  for(;;) {
    func_136C9();

    if(!func_FF26()) {
      continue;
    }
    wait(randomfloatrange(1, 3));

    if(self.var_AEDF.locked) {
      func_51FA();
    }
  }
}

func_FF26() {
  if(randomint(100) < 100 * level.var_D127.var_68AB.var_5BE3) {
    return 1;
  } else {
    return 0;
  }
}

func_51FA() {
  var_0 = (1500, 0, 0);
  var_1 = spawnvehicle("veh_mil_air_un_jackal_02", "player_attack_drone_anchor", "jackal_un", level.var_D127.origin + rotatevector(var_0, level.var_D127.angles), level.var_D127.angles);
  func_0BDC::func_1994(level.var_D127, var_0, 200, 1.0, 500, 1.0);
}

func_136C9() {
  self endon("terminate_ai_threads");
  self endon("death");
  self waittill("player_is_locked");
}