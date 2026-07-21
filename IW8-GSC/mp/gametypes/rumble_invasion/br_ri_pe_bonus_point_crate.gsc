/***********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\rumble_invasion\br_ri_pe_bonus_point_crate.gsc
***********************************************************************/

init() {
  _killstreakneedslocationselection::thread_endon_death();
  level.current_safehouse_spawn_structs.specialistbr = getdvarint("_encstr_BEBC2803B602894EEAFF695BE78218C8BD0A0EFBDD715805A1E7655B639A482052E5531349B4983D3AE3", 6);
  level.current_safehouse_spawn_structs.specialdayloadouts = getdvarint("_encstr_8F55288F6913C962F05FBB0BA62A4795931F87FB472FADBB5709430690D786FA1350B02B49F6D26D2B78", 3);
  level.current_safehouse_spawn_structs.spectateprop = getdvarint("_encstr_920C23620E2531BAE0291B7711FB6F9AC51DEA916FA35BCFC928573B28F65B4291B5F3525D", 10);
  level.current_safehouse_spawn_structs.parachutecancutautodeploy = getdvarfloat("_encstr_838424DAB6EDF96238E1E3BFC9B12D92A3D3A9162D59B3BD417067BFD849F4CA07E56ACD0FBF", 30.0);
  level.current_safehouse_spawn_structs.spectatableprops = getdvarint("_encstr_84DD27430E5BF92BE3F1835B5F88E8698328C73F5947823FAD0FAC695A95E5F919FF39B855C7A573EB", 0);
  level.current_safehouse_spawn_structs.spawnzombiedogtags = getdvarfloat("_encstr_82B129A3174001136B0EEBA21636AF8580DF1728B730157318A1C3EA9B9D37BE8841B495E50891BB3B188A", 5.0);
  level.current_safehouse_spawn_structs.spectateprop = getdvarint("_encstr_929C211F43A321C0E8E7F8BAE6E0FF3005D23F6A2F374E6BB00FC2F75BEFBFDE5038AF", 10);
  level.current_safehouse_spawn_structs.specialistperk = getDvar("_encstr_82E626B936C9F59CA5F50E95FA13B7E6EA6EFAC1ED5AB9A3EB6CC9854795FADE1353B28DA3D2ECAC", "_encstr_8EDC13C342AD1F972FFA30F06BAB96E7408CEFA230");
  var_0 = spawnStruct();
  var_0.weight = getdvarfloat("_encstr_8CB123E603AB8E8D3481F8A8790E7F606FBB78DF97AFD0D9916AE080E3E7671B8759FC5BE4", 1.0);
  var_0.attackerswaittime = ::attackerswaittime;
  var_0._id_140CF = ::_id_140CF;
  var_0._id_14382 = ::_id_14382;
  var_0._id_11B78 = getdvarint("_encstr_AAFD2683A85579638830E8F52831CFFDB3D0C92B60DB6D332606D2E955F94745C32031E3C8BB67D7", 1);
  var_0.guard_door_clip = _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::relic_squadlink_init_vfx("_encstr_B67B0A1A2C279107DBB49BA3", "_encstr_83C1202681010104A601104003040180600408101006808040C00180048101801006");
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_12B35(102, var_0);
  _killstreakneedslocationselection::subtract_from_spawn_count_from_group();
  thread zombienumhitscar();
}

_id_140CF() {
  return 0;
}

_id_14382() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8A431478F7784BCAC97FDB3836432F5B17EDD3F7F8EB");
  var_0 = forest_combat();
  wait(var_0);
}

forest_combat() {
  var_0 = getdvarfloat("_encstr_A2852ACDC627FA9CB4BE0E59BE98DB37EA6EAF83ED96DCD17DD84EB01D2BFA6E470BC9D1E8B45B56F5B5A5B9", 795);
  var_1 = getdvarfloat("_encstr_AB852ADCC64EEB272DF5C1B2D798BDDCEA9BFAC1F6B473D1FA36390B3A2BD79BE858E41DA396B695F5AD2C3C", 1110);

  if(var_1 > var_0)
    return randomfloatrange(var_0, var_1);
  else
    return var_0;
}

attackerswaittime() {
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_B2741B92608527DF769398E1C243E7E7138A08F96F8007A3F1A0B8B159", 0);
  _killstreakneedslocationselection::_id_12293();
}

zombienumhitscar() {
  waitframe();

  if(!isDefined(level.current_safehouse_spawn_structs._id_12E2C)) {
    level.current_safehouse_spawn_structs._id_12E2C = spawnStruct();
    level.current_safehouse_spawn_structs._id_12E2C._id_13904 = "_encstr_AC46111E7BF2E5907D6F40707785AB3F5A6598";
  }

  level.current_safehouse_spawn_structs._id_12E2C.arena_bot_pickup_weapon = undefined;
  var_0 = level.currentability;

  if(var_0.size > 0) {
    var_1 = [];

    foreach(var_3 in var_0)
    var_1[var_1.size] = var_3.origin;

    level.current_safehouse_spawn_structs._id_12E2C.arena_bot_pickup_weapon = var_1;

    if(var_1.size <= level.current_safehouse_spawn_structs.specialistbr) {
      level.current_safehouse_spawn_structs.specialistbr = var_1.size;

      if(level.current_safehouse_spawn_structs.specialdayloadouts > var_1.size)
        level.current_safehouse_spawn_structs.specialdayloadouts = var_1.size;
    }
  }
}

killed_by_chopper() {
  waittillframeend;
  _encstr_A3E63D4B48685ABF8B4338B8E0B83B5921A9554ACA589BB6FAD5A9ED6B11F61B1F97BBCD9CA003535018A9A69B63C0C5D2168B28672B4B01113808865FF071::initstructs();
  level.currentability = scripts\engine\utility::getStructArray("_encstr_8501241393925DDA13B1B2A4E6D9FA13ED73EA9BD7C1ED4BDC1DEB1BE40B1D2BEB19E4BDE0CD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
}