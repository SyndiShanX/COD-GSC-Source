/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_electricswitch.gsc
***********************************************/

main() {
  script_model_anims();
}

setup_switch(var_0) {
  var_1 = getEnt(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 scripts\cp\utility::sethintobject("_encstr_8A150902C868E7C591301A", "_encstr_BA110C20C7C0F307EDF9111CB7A1", "_encstr_9A2E1472F83F45A779F9ADA38DE3074E4B18997A30C9", &"_encstr_95B81887C91F49FBC6A43FC768A4F1A1E111AFC02F0F0C6109A5", 25, "_encstr_82370F09B522B08D175A6876A32BC8E07B", "_encstr_BECC055CF3811A", 128, 120, 70, 45);
  var_2 = spawnStruct();
  var_1.scenenode = var_0;
  var_1 scripts\engine\utility::ent_flag_init("_encstr_85390A0F377AD5E89029E8C0");

  if(isDefined(var_1))
    var_1 thread switch_think();

  return var_1;
}

switch_think() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    self makeunusable();
    var_1 = scripts\cp_mp\anim_scene::anim_scene_create_actor(var_0, "_encstr_92130BA089B1A0B29E8F23EA62", 1);
    var_2 = scripts\cp_mp\anim_scene::anim_scene_create_actor(self, "_encstr_9A280DCCAB37564CDB0FF51C39DEE0");

    if(!scripts\engine\utility::ent_flag("_encstr_85390A0F377AD5E89029E8C0")) {
      var_2 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "_encstr_AC010C3955ECA9038931DB187790", 1);
      var_3 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var_2], "_encstr_AC010C3955ECA9038931DB187790");

      if(var_3) {
        scripts\engine\utility::ent_flag_set("_encstr_85390A0F377AD5E89029E8C0");
        self setHintString(&"_encstr_A554196882AF4DA2A452A515BC8A554A72EBE91991BE50260A29A6");
      }
    } else {
      var_2 scripts\cp_mp\anim_scene::anim_scene_set_actor_interruptable(1, "_encstr_8FF009022583A82537F313", 1);
      var_3 = self.scenenode scripts\cp_mp\anim_scene::anim_scene([var_2], "_encstr_8FF009022583A82537F313");

      if(var_3) {
        scripts\engine\utility::ent_flag_clear("_encstr_85390A0F377AD5E89029E8C0");
        self setHintString(&"_encstr_95B81887C91F49FBC6A43FC768A4F1A1E111AFC02F0F0C6109A5");
      }
    }

    self notify("_encstr_8FF009022583A82537F313", var_0);
    self makeusable();
    var_1 = undefined;
    var_2 = undefined;
  }
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

script_model_anims() {
  level.scr_animtree["_encstr_92130BA089B1A0B29E8F23EA62"] = #animtree;
  level.scr_anim["_encstr_92130BA089B1A0B29E8F23EA62"]["_encstr_8FF009022583A82537F313"] = % _encstr_BE8A12A321392DEB5170B54A476118C361F3A2A3;
  level.scr_animname["_encstr_92130BA089B1A0B29E8F23EA62"]["_encstr_8FF009022583A82537F313"] = "_encstr_BE8A12A321392DEB5170B54A476118C361F3A2A3";
  level.scr_eventanim["_encstr_92130BA089B1A0B29E8F23EA62"]["_encstr_8FF009022583A82537F313"] = "_encstr_BE8A12A321392DEB5170B54A476118C361F3A2A3";
  level.scr_anim["_encstr_92130BA089B1A0B29E8F23EA62"]["_encstr_AC010C3955ECA9038931DB187790"] = % _encstr_AB461A73C5FF881F592B53275FF26828A71BBB6BAD172058715B692D;
  level.scr_animname["_encstr_92130BA089B1A0B29E8F23EA62"]["_encstr_AC010C3955ECA9038931DB187790"] = "_encstr_AB461A73C5FF881F592B53275FF26828A71BBB6BAD172058715B692D";
  level.scr_eventanim["_encstr_92130BA089B1A0B29E8F23EA62"]["_encstr_AC010C3955ECA9038931DB187790"] = "_encstr_AB461A73C5FF881F592B53275FF26828A71BBB6BAD172058715B692D";
  level.scr_animtree["_encstr_9A280DCCAB37564CDB0FF51C39DEE0"] = #animtree;
  level.scr_anim["_encstr_9A280DCCAB37564CDB0FF51C39DEE0"]["_encstr_8FF009022583A82537F313"] = % _encstr_865213E307992DCB11E24BD34A0DE06391EA884A1F;
  level.scr_animname["_encstr_9A280DCCAB37564CDB0FF51C39DEE0"]["_encstr_8FF009022583A82537F313"] = "_encstr_865213E307992DCB11E24BD34A0DE06391EA884A1F";
  level.scr_anim["_encstr_9A280DCCAB37564CDB0FF51C39DEE0"]["_encstr_AC010C3955ECA9038931DB187790"] = % _encstr_B2A41BF7C996EF2ACF58336B788DE5D3CE2D7D8AD03E7F3527834BA2B8;
  level.scr_animname["_encstr_9A280DCCAB37564CDB0FF51C39DEE0"]["_encstr_AC010C3955ECA9038931DB187790"] = "_encstr_B2A41BF7C996EF2ACF58336B788DE5D3CE2D7D8AD03E7F3527834BA2B8";
}