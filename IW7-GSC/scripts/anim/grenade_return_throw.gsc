/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\grenade_return_throw.gsc
*************************************************/

main() {
  if(getdvarint("ai_iw7", 0) == 1) {
    scripts\asm\asm::asm_fireephemeralevent("grenade response", "return throw");
    self endon("killanimscript");
    self endon("death");
    self waittill("killanimscript");
  }

  self orientmode("face enemy");
  self endon("killanimscript");
  scripts\anim\utility::func_9832("grenade_return_throw");
  self animmode("zonly_physics");
  var_0 = undefined;
  var_1 = 1000;
  if(isDefined(self.enemy)) {
    var_1 = distance(self.origin, self.enemy.origin);
  }

  var_2 = [];
  if(var_1 < 600 && func_9E8C()) {
    if(var_1 < 300) {
      var_2 = scripts\anim\utility::func_B027("grenade", "return_throw_short");
    } else {
      var_2 = scripts\anim\utility::func_B027("grenade", "return_throw_long");
    }
  }

  if(var_2.size == 0) {
    var_2 = scripts\anim\utility::func_B027("grenade", "return_throw_default");
  }

  var_0 = var_2[randomint(var_2.size)];
  self func_82E4("throwanim", var_0, % body, 1, 0.3);
  var_4 = animhasnotetrack(var_0, "grenade_left") || animhasnotetrack(var_0, "grenade_right");
  if(var_4) {
    scripts\anim\shared::placeweaponon(self.weapon, "left");
    thread func_DB3A();
    thread func_C162("throwanim", "grenade_left");
    thread func_C162("throwanim", "grenade_right");
    self waittill("grenade_pickup");
    self func_8228();
    scripts\anim\battlechatter_ai::func_67CF("frag");
    self waittillmatch("grenade_throw", "throwanim");
  } else {
    self waittillmatch("grenade_throw", "throwanim");
    self func_8228();
    scripts\anim\battlechatter_ai::func_67CF("frag");
  }

  if(isDefined(self.objective_position)) {
    self func_83C2();
  }

  wait(1);
  if(var_4) {
    self notify("put_weapon_back_in_right_hand");
    scripts\anim\shared::placeweaponon(self.weapon, "right");
  }
}

func_9E8C() {
  var_0 = (self.origin[0], self.origin[1], self.origin[2] + 20);
  var_1 = var_0 + anglesToForward(self.angles) * 50;
  return sighttracepassed(var_0, var_1, 0, undefined);
}

func_DB3A() {
  self endon("death");
  self endon("put_weapon_back_in_right_hand");
  self waittill("killanimscript");
  scripts\anim\shared::placeweaponon(self.weapon, "right");
}

func_C162(var_0, var_1) {
  self endon("killanimscript");
  self endon("grenade_pickup");
  self waittillmatch(var_1, var_0);
  self notify("grenade_pickup");
}