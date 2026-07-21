/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gxp_fear.gsc
***********************************************/

init() {
  level.disable_super_in_turret.placementstatsset = 0;

  if(!getdvarint("_encstr_A94C10371B9CAF8993AFCE87C1BE6656B09C", 0)) {
    return;
  }
  level.disable_super_in_turret.platform_model = [];
  level.disable_super_in_turret.play_3p_anim = 0;
  level thread _id_143F9();
  tr_vis_radius_override_lod1();
}

tr_vis_radius_override_lod1() {
  level.disable_super_in_turret.play_3p_anim_non_animscene = spawnStruct();
  level.disable_super_in_turret.play_3p_anim_non_animscene._id_11C1C = getdvarint("_encstr_8D870D4B568A1FB02D179B99B24B13", 0);
  level.disable_super_in_turret.play_3p_anim_non_animscene._id_11B5E = getdvarint("_encstr_A6870DB3E9BEF717B85BD2F76BB0D8", 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene.setsuperweapondisabledbr = level.disable_super_in_turret.play_3p_anim_non_animscene._id_11B5E / 2.0;
  level.disable_super_in_turret.play_3p_anim_non_animscene.is_wave_gametype = getdvarint("_encstr_B1BE14D2AF1B49E365C2A0A1146EC0D77FC1AF93FFCB", 100);
  level.disable_super_in_turret.play_3p_anim_non_animscene.isangleoffset = getdvarfloat("_encstr_BEB417F05AF2CFB9EFE1BE20FC27AD7B1F821968324EF1119B", 2.0);
  level.disable_super_in_turret.play_3p_anim_non_animscene.calloutmarkerpingvo_playpredictivepinginventoryrequest = getdvarfloat("_encstr_8CC41D9BB19CBE99AC0B9CD7589CB5F639EB9185D685EC56D76E6C0B632C39", 2.0);
  level.disable_super_in_turret.play_3p_anim_non_animscene._id_1423C = getdvarfloat("_encstr_88A11F9BC64E7D33AC2C39FA3B95865A6CB1567D19B06B0B9D95AFE636161B2C93", 2.0);
  level.disable_super_in_turret.play_3p_anim_non_animscene.circle_speed = int(getdvarfloat("_encstr_BD671BA643EBCEE57722A8B96A0E87C1CBE1A015E76F10195F3B8040A2", 1.0) * 1000);
  level.disable_super_in_turret.play_3p_anim_non_animscene.circle_acceleration = getdvarint("_encstr_9B241C83D98EC727E80BA28725E02A973930CA6AA6EBCB5E087BA58525B0", 2);
  level.disable_super_in_turret.play_3p_anim_non_animscene.circle_back_to_combat = getdvarint("_encstr_926124D872DAF781C73966C812FFEB5B853AC8E029B4DD79E325E1DDE673561FAEC2B018924F", 2);
  level.disable_super_in_turret.play_3p_anim_non_animscene.circle_defaults = getdvarint("_encstr_84CF23B3069219D4BA771DBF8302A62B541C98C9A1E1E81EE34F2BC39B7BF848F875A363D2", 3);
  level.disable_super_in_turret.play_3p_anim_non_animscene.saw_headicons = getdvarint("_encstr_BE8816F37E20A8ACDBA9E3C7A168E09B21919B774A1257E3", 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene.sat_wait_for_controller = int(getdvarfloat("_encstr_AAE41838923A176127D98668B77B0817E3F950587B1785BB0FCC", 5.0) * 1000);
  level.disable_super_in_turret.play_3p_anim_non_animscene.scn_infil_hackney_heli_npc5 = getdvarint("_encstr_AA711EFF6F73CE011D2F9AC031E3CABF4BB13BFBD967938B6EC47E53AA4780D3", 25);
  level.disable_super_in_turret.play_3p_anim_non_animscene._id_1209E = int(getdvarfloat("_encstr_BD541A7358A5E9A3999F5A7FA0C0D3AF2BB01AAA08535CD7D071557C", 0.15) * 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene._id_1204D = int(getdvarfloat("_encstr_B6E2206393B671855DE732A7F7A668383F1BFB2481732D31C8FBDDF57B874697CC42", 0.15) * 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene._id_1204E = int(getdvarfloat("_encstr_BEF2241A183B514690BBE0C9E0201321C3E56331FFE37079806BAA3005C9A30BC7C720628CC7", 0.15) * 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene._id_12049 = int(getdvarfloat("_encstr_919A1C0F8B7A19EC4FC2832E4A0B12D095EC9789226720A293FA1851F243", 0.1) * 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene._id_12022 = int(getdvarfloat("_encstr_B88E1A1B42BBC0583F01BDEF27A518108FDAD241CB1F0320D51DBDA1", 0.1) * 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene._id_12068 = int(getdvarfloat("_encstr_9A8F16CD8DE4F599B22CC9FAB7DC381B0BF256E48C96598C", 0.1) * 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene._id_12055 = int(getdvarfloat("_encstr_A6231C4F98CBD7EA5B270271186502BF304873B7D860358289C64EF6FE2B", 0.1) * 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene.onplayerkilled = int(getdvarfloat("_encstr_B1ED189F728A6EB0F7CAFD0712CD7B7DEB4B189AFC3961595924", 0.15) * 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene._id_12039 = int(getdvarfloat("_encstr_8F1C17DB16EBDF075398AB717BADBFFBA086444BBB705B8F09", 0.25) * 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene._id_12050 = int(getdvarfloat("_encstr_A5BB1B120E23DF0F42C9DA1E0F6DC98EC3235F2862ABD8B3D5851BC83D", 0.2) * 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene._id_11FFF = int(getdvarfloat("_encstr_A13516CE2E8BD89AFF22E36190A8BEB329A06BEB40AB9037", 0.05) * 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene._id_12008 = int(getdvarfloat("_encstr_B1D41CB936277D33AC1693BEBDE6D8DECD1DE458B18E6CF6B60EB1CA1DB2", 0.1) * 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene.gasmask_onpickupcreated = getdvarint("_encstr_9A2F1ED3F8050943797FBA9F0681178A5B081AA970DD7E9F5148A0DDA6A8D757", 3);
  level.disable_super_in_turret.play_3p_anim_non_animscene.gasgrenade_crate_use = getdvarint("_encstr_B8822040AE03493E5DC21BB7A6096D0362E511A9ED72460B8096529950EF8577023F", 50);
  level.disable_super_in_turret.play_3p_anim_non_animscene.gasgrenade_crate_player_at_max_ammo = getdvarint("_encstr_97041AC7CF3EF166D0D97231B1D8A5BB1B7D0FFFB9EB7B4C28C02E87", 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene.gasgrenade_crate_spawn = getdvarint("_encstr_A76A1ECD6C9CAFCCCA16C9D78D0B5B0E4BE6B3FA46966EA30B376C2BF5D8B0C1", 5000);
  level.disable_super_in_turret.play_3p_anim_non_animscene.clear_players_from_door_way_think = [];
  level.disable_super_in_turret.play_3p_anim_non_animscene.clear_players_from_door_way_think[0] = "_encstr_87B81741924F28A07B5FE5FBBF63E0180D2ECB1B71D0806C72";
  level.disable_super_in_turret.play_3p_anim_non_animscene.clear_players_from_door_way_think[1] = "_encstr_87B81741924F28A07B5FE5FBBF63E0180D2ECB1B71D0806C72";
  level.disable_super_in_turret.play_3p_anim_non_animscene.clear_players_from_door_way_think[2] = "_encstr_8D7916805BCF6157E3A944DD3E7BEF485DAF88A88784382F";
  level.disable_super_in_turret.play_3p_anim_non_animscene._id_138AE = [];
  level.disable_super_in_turret.play_3p_anim_non_animscene._id_138AE[0] = "_encstr_87F91698E4AFECDEB37D33B20BC9FA77863707BE34B4B343";
  level.disable_super_in_turret.play_3p_anim_non_animscene._id_13B4A = [];
  level.disable_super_in_turret.play_3p_anim_non_animscene._id_13B4A[0] = "_encstr_831D17FDF3F7F7B0F32779DFE15B50F28D0B660FFE7824F8E8";
  level.disable_super_in_turret.play_3p_anim_non_animscene._id_13B4A[1] = "_encstr_A66816784BB9BF98A3DFB43DF96B465FDB4290C8F14DE3B1";
  level.disable_super_in_turret.play_3p_anim_non_animscene._id_13B4A[2] = "_encstr_A16816C493EB76DECED7332BB039F5CD47D2CDECEB36DBBB";
}

_id_143F9() {
  waittillframeend;
  scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");

  foreach(var_2, var_1 in level.br_pickups.br_equipname) {}

  level.disable_super_in_turret.placementstatsset = 1;

  if(istrue(level.br_infils_disabled)) {
    foreach(var_4 in level.players)
    var_4 thread lethal_crate_spawn();
  }

  _id_12B20("_encstr_A6FE1037D0F9C851EBBD03DD61CD095F1FF9", ::plant_bomb_cleanup_on_death);
  _id_12B20("_encstr_96D415F530CF7BE14B0DADB97525E093C9272847BF4D31", ::plant_add_zplanes_override);
  _id_12B20("_encstr_959211381051B3070B4EBC2E96C9A3937312EA", ::plane_landing_fx);
  _id_12B20("_encstr_A73D132F4D2A1AE4E0136BF2C9503B4487F5879F1D", ::plane_door_opened);
  _id_12B20("_encstr_B40E115F3A41CA9EE58AFA80572CA3ED648D48", ::plane, level.disable_super_in_turret.play_3p_anim_non_animscene._id_1209E);
  _id_12B20("_encstr_8F520D7BE6A0D8C297594E114B598C", ::plane, level.disable_super_in_turret.play_3p_anim_non_animscene._id_12068);
  _id_12B20("_encstr_87EE111FD06FCD2A6306A59FED1B329111208B", ::plate_dest);
  _id_12B20("_encstr_B47D143D35296AB7506FC82C37FC28F706E0E8D76DA5", ::plant_enemy_claymore);
  _id_12B20("_encstr_AFE212DE73622CE6E8D4E80BE62349569D2D9D59", ::placing_c4_interaction_use_monitor, level.disable_super_in_turret.play_3p_anim_non_animscene._id_12050);
  _id_12B20("_encstr_8BAA0D6F98B6638032CB176411995F", ::placing_c4_interaction_use_monitor, level.disable_super_in_turret.play_3p_anim_non_animscene._id_11FFF);
  _id_12B20("_encstr_9A8B0EBDB986F69B3A4E851B3A8A3719", ::plane_collmap, level.disable_super_in_turret.play_3p_anim_non_animscene._id_12008);
  _id_12B20("_encstr_A3290E808A575F48C5148F9734A65023", ::planewaittillcandrop);
  _id_12B20("_encstr_8CDB0F17758F62C1503912545010040A7D", ::plant_remove_zplanes_override);
  level thread _id_13FEE();

  if(!getdvarint("_encstr_B1872C5780D3FF824DAF6FA0FF6F9A819B089B9318AE307A59A1F31E6B250244601033D7486071A393467153C4D1", 0))
    level thread _encstr_8E222ECD6C4E96071DCD975B83CB7658B5AC3ABCE02BB9BC2627FACEE183FAD0B0638D57C6B4CD2C8ED2BDDC8BCEE6D8::_id_11E33();
}

start_preserverroom_spawners(var_0) {
  var_1 = remove_flag_trig();
  self.setarenaomnvarhealthtype = clamp(self.setarenaomnvarhealthtype + var_0, level.disable_super_in_turret.play_3p_anim_non_animscene._id_11C1C, level.disable_super_in_turret.play_3p_anim_non_animscene._id_11B5E);
  self setclientomnvar("_encstr_A3AA111D9BC162DDC15CA7B00390BAA3B0B735", (self.setarenaomnvarhealthtype - level.disable_super_in_turret.play_3p_anim_non_animscene._id_11C1C) / (level.disable_super_in_turret.play_3p_anim_non_animscene._id_11B5E - level.disable_super_in_turret.play_3p_anim_non_animscene._id_11C1C));
  place_bad_place_until_flag(var_1);
}

juggernaut_damage_thread(var_0) {
  self.setarenaomnvarhealthtype = clamp(self.setarenaomnvarhealthtype - var_0, level.disable_super_in_turret.play_3p_anim_non_animscene._id_11C1C, level.disable_super_in_turret.play_3p_anim_non_animscene._id_11B5E);
  self setclientomnvar("_encstr_A3AA111D9BC162DDC15CA7B00390BAA3B0B735", (self.setarenaomnvarhealthtype - level.disable_super_in_turret.play_3p_anim_non_animscene._id_11C1C) / (level.disable_super_in_turret.play_3p_anim_non_animscene._id_11B5E - level.disable_super_in_turret.play_3p_anim_non_animscene._id_11C1C));
}

get_ai_hearing_bomb_plant_sound() {
  if(istrue(self.setcheckliststateforteam))
    return 0;

  if(self.setarenaomnvarhealthtype >= level.disable_super_in_turret.play_3p_anim_non_animscene.setsuperweapondisabledbr)
    return 1;

  return 0;
}

remove_flag_trig() {
  if(self.setarenaomnvarhealthtype < level.disable_super_in_turret.play_3p_anim_non_animscene.setsuperweapondisabledbr)
    return 0.0;

  return (self.setarenaomnvarhealthtype - level.disable_super_in_turret.play_3p_anim_non_animscene.setsuperweapondisabledbr) / (level.disable_super_in_turret.play_3p_anim_non_animscene._id_11B5E - level.disable_super_in_turret.play_3p_anim_non_animscene.setsuperweapondisabledbr);
}

onplayerconnect(var_0) {
  if(!getdvarint("_encstr_A94C10371B9CAF8993AFCE87C1BE6656B09C", 0)) {
    return;
  }
  var_0 headlessinfils();
}

onplayerspawned() {
  if(!level.disable_super_in_turret.placementstatsset) {
    return;
  }
  headlessinfils();
  thread lethal_crate_spawn();
}

placementupdatewait(var_0, var_1, var_2) {
  if(!level.disable_super_in_turret.placementstatsset) {
    return;
  }
  if(!isDefined(level.disable_super_in_turret.platform_model[var_0].function))
    scripts\mp\utility\script::laststand_dogtags(var_0 + "_encstr_B61D20104BB908DC7B47102356999673B2C8404B9B04D14EB43B3B59E4C82B58278B");

  if(isDefined(level.disable_super_in_turret.platform_model[var_0].function)) {
    if(isDefined(var_2))
      return [[level.disable_super_in_turret.platform_model[var_0].function]](level.disable_super_in_turret.platform_model[var_0].value, var_1, var_2);
    else if(isDefined(var_1))
      return [[level.disable_super_in_turret.platform_model[var_0].function]](level.disable_super_in_turret.platform_model[var_0].value, var_1);
    else
      return [[level.disable_super_in_turret.platform_model[var_0].function]](level.disable_super_in_turret.platform_model[var_0].value);
  }
}

_id_12B20(var_0, var_1, var_2) {
  if(isDefined(level.disable_super_in_turret.platform_model[var_0]))
    scripts\mp\utility\script::laststand_dogtags("_encstr_82AF1FA21BE88C17E549CB9051B7DBCE20D33B3D2970956B05E1A26B111BCFBA82" + var_0 + "_encstr_A2920A0291CACCB49B5923C5");

  if(!isDefined(var_2))
    var_2 = 0.0;

  level.disable_super_in_turret.platform_model[var_0] = spawnStruct();
  level.disable_super_in_turret.platform_model[var_0].function = var_1;
  level.disable_super_in_turret.platform_model[var_0].value = var_2;
}

headlessinfils() {
  self.setarenaomnvarhealthtype = 0;
  self.setarenaomnvarplayertype = gettime();
  self.setbeingrevivedinternal = 0;
  self.setbrokenoverlaymaterial = gettime();
  self.setbettermissionrewards = 0;
  self.setburningdamage = 0;
  self.setburningpartstate = gettime();
  self.setbrjuggsettings = self.origin + (0, 0, 1) * level.disable_super_in_turret.play_3p_anim_non_animscene.gasgrenade_crate_spawn;
}

unset_heavy_hitter() {
  return 0;
}

_id_13B0C() {
  var_0 = level.disable_super_in_turret.play_3p_anim_non_animscene.gasmask_onpickupcreated;
  var_1 = 1;

  if(unset_heavy_hitter())
    var_1 = 0;
  else {
    var_2 = vectorNormalize(self.setbrjuggsettings - self.origin);
    var_3 = distance(self.origin, self.setbrjuggsettings);
    var_4 = clamp(var_3 - level.disable_super_in_turret.play_3p_anim_non_animscene.gasgrenade_crate_use * level.disable_super_in_turret.play_3p_anim_non_animscene.circle_speed * 0.001, 0, level.disable_super_in_turret.play_3p_anim_non_animscene.gasgrenade_crate_spawn);
    self.setbrjuggsettings = self.origin + var_2 * var_4;

    if(var_4 < level.disable_super_in_turret.play_3p_anim_non_animscene.gasgrenade_crate_player_at_max_ammo)
      self.setbettermissionrewards = 1;
    else
      self.setbettermissionrewards = 0;

    if(self.setbettermissionrewards == 0)
      var_1 = 0;
  }

  if(var_1 == 0) {
    self.setbeingrevivedinternal = 0;
    return 0;
  } else {
    self.setbeingrevivedinternal++;

    if(self.setbeingrevivedinternal >= var_0)
      return 1;
  }

  return 0;
}

calloutmarkerping_initcommon() {
  if(self.setburningpartstate + level.disable_super_in_turret.play_3p_anim_non_animscene.sat_wait_for_controller < gettime()) {
    self.setburningpartstate = gettime();
    var_0 = scripts\mp\utility\player::getplayersinradius(self.origin, level.disable_super_in_turret.play_3p_anim_non_animscene.saw_headicons);

    foreach(var_2 in var_0) {
      if(var_2.team == self.team && self.squadindex == self.squadindex) {
        continue;
      }
      if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC()) {
        self.setburningdamage = 1;
        break;
      }
    }
  }

  return self.setburningdamage;
}

trackendangeredobjs() {
  return _encstr_8EF62B63396EFF42C08F5F1561F24F2719118B4BE34DDFED28B537E769301927B7E91291CA1073B7886507FB77::truckdoorleft(self);
}

circle_acceleration() {
  if(self.setarenaomnvarplayertype + level.disable_super_in_turret.play_3p_anim_non_animscene.circle_speed < gettime()) {
    var_0 = trackendangeredobjs();
    _encstr_85332FC8DF2260A903E2A0993AEEDF29957F78CB7BCDFBDF4ACA909456221333D94348B9BF78D307E274F0A6EB2E6F1B2B::_id_13FDD("_encstr_97180B6BB0F1F290101312A81B", var_0);

    if(var_0)
      juggernaut_damage_thread(level.disable_super_in_turret._id_12E6C);
    else {
      var_1 = level.disable_super_in_turret.play_3p_anim_non_animscene.circle_acceleration;

      if(_id_13B0C())
        var_1 = var_1 + level.disable_super_in_turret.play_3p_anim_non_animscene.circle_back_to_combat;

      if(calloutmarkerping_initcommon())
        var_1 = var_1 + level.disable_super_in_turret.play_3p_anim_non_animscene.circle_defaults;

      start_preserverroom_spawners(var_1);
    }

    self.setarenaomnvarplayertype = gettime();
  }
}

_id_13312() {
  if(self.sessionstate != "_encstr_877508C1D8C22F2DDC3B")
    return 0;

  if(scripts\mp\utility\game::updatehistoryhud(self))
    return 0;

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC())
    return 0;

  if(istrue(self.inlaststand))
    return 0;

  return 1;
}

_id_132EE() {
  if(self.sessionstate != "_encstr_877508C1D8C22F2DDC3B")
    return 1;

  if(scripts\mp\utility\game::updatehistoryhud(self))
    return 1;

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC())
    return 1;

  return 0;
}

_id_13FD7() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(_id_13312()) {
    circle_acceleration();

    if(get_ai_hearing_bomb_plant_sound())
      _encstr_8E222ECD6C4E96071DCD975B83CB7658B5AC3ABCE02BB9BC2627FACEE183FAD0B0638D57C6B4CD2C8ED2BDDC8BCEE6D8::update(remove_flag_trig());
    else
      _encstr_8E222ECD6C4E96071DCD975B83CB7658B5AC3ABCE02BB9BC2627FACEE183FAD0B0638D57C6B4CD2C8ED2BDDC8BCEE6D8::has_target_player();

    return;
  }

  _encstr_8E222ECD6C4E96071DCD975B83CB7658B5AC3ABCE02BB9BC2627FACEE183FAD0B0638D57C6B4CD2C8ED2BDDC8BCEE6D8::has_target_player();

  if(_id_132EE())
    headlessinfils();
}

_id_13FEE() {
  for(;;) {
    if(isDefined(level.players) && level.players.size) {
      level.disable_super_in_turret.play_3p_anim = level.disable_super_in_turret.play_3p_anim % level.players.size;
      var_0 = clamp(10, 1, level.players.size);

      for(var_1 = 0; var_1 < var_0; var_1++) {
        var_2 = level.disable_super_in_turret.play_3p_anim;
        var_3 = level.players[var_2];
        level.disable_super_in_turret.play_3p_anim = (level.disable_super_in_turret.play_3p_anim + 1) % level.players.size;
        var_3 thread _id_13FD7();
        var_3 thread pkg_lbl_vo();
      }
    }

    wait 0.05;
  }
}

plane(var_0, var_1) {
  start_preserverroom_spawners(var_0);
}

plant_bomb_cleanup_on_death(var_0, var_1) {
  var_2 = var_1.objweapon.basename;
  var_3 = scripts\mp\utility\weapon::getequipmenttype(var_2);

  if(isDefined(var_3)) {
    if(var_3 == "_encstr_B68610ACC5ABA50EB5CAB9A3F5DEA30D5693" || var_3 == "_encstr_99C209E34FC743616118AB") {
      start_preserverroom_spawners(level.disable_super_in_turret.play_3p_anim_non_animscene._id_12022);
      return;
    }
  }

  if(var_2 == "_encstr_81931411E5B039F5EB6F052B97F3C90B617F7BAE0D18") {
    start_preserverroom_spawners(level.disable_super_in_turret.play_3p_anim_non_animscene.scn_infil_hackney_heli_npc5);
    return;
  }

  var_4 = clamp(var_1.damage, 0, level.disable_super_in_turret.play_3p_anim_non_animscene.is_wave_gametype);
  var_5 = var_4 * level.disable_super_in_turret.play_3p_anim_non_animscene.isangleoffset;
  start_preserverroom_spawners(var_5);
}

plant_add_zplanes_override(var_0, var_1) {
  if(!isDefined(var_1.stack_patch_waittill_stack) || !var_1.stack_patch_waittill_stack) {
    var_2 = clamp(var_1.is_spawner_position_valid, 0, level.disable_super_in_turret.play_3p_anim_non_animscene.is_wave_gametype);
    var_3 = var_2 * level.disable_super_in_turret.play_3p_anim_non_animscene.calloutmarkerpingvo_playpredictivepinginventoryrequest;
    start_preserverroom_spawners(var_3);
  }
}

plate_dest(var_0, var_1) {
  var_2 = clamp(var_1.damage, 0, level.disable_super_in_turret.play_3p_anim_non_animscene.is_wave_gametype);
  var_3 = var_2 * level.disable_super_in_turret.play_3p_anim_non_animscene._id_1423C;
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  if(isDefined(var_4)) {
    foreach(var_6 in var_4) {
      if(isDefined(var_6) && isalive(var_6))
        var_6 start_preserverroom_spawners(var_3);
    }
  }
}

plane_landing_fx(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  if(self == var_1)
    start_preserverroom_spawners(level.disable_super_in_turret.play_3p_anim_non_animscene._id_1204D);
  else
    start_preserverroom_spawners(level.disable_super_in_turret.play_3p_anim_non_animscene._id_1204E);
}

plane_door_opened(var_0, var_1) {
  if(istrue(var_1._id_12466) && scripts\mp\utility\killstreak::getkillstreakenemyusedialogue(var_1._id_11ED2)) {
    var_2 = level.disable_super_in_turret.play_3p_anim_non_animscene._id_12049;
    start_preserverroom_spawners(var_2);
  }
}

placing_c4_interaction_use_monitor(var_0, var_1) {
  juggernaut_damage_thread(var_0);
}

plant_enemy_claymore(var_0, var_1) {
  _encstr_9A1F34B98D3996838EB9BCAD07793B85DAB2D15E1CAC9B7913E4AFEC0BADB2D12F1C2BF59DE11CAF36860B1B3695379DB2CD8B9D37B1::_id_11FF0(self, var_0);
  var_2 = var_1.pity_timer_end_time * level.disable_super_in_turret.play_3p_anim_non_animscene._id_11B5E;
  juggernaut_damage_thread(var_2);
}

plane_collmap(var_0, var_1) {
  if(var_1 == 1)
    juggernaut_damage_thread(var_0);
}

planewaittillcandrop(var_0) {
  if(_getactualcost::_id_13E19())
    start_preserverroom_spawners(level.disable_super_in_turret.play_3p_anim_non_animscene._id_12055);
}

plant_remove_zplanes_override(var_0, var_1) {
  var_2 = var_1.victim;
  var_3 = var_1.attacker;

  if(var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC())
    juggernaut_damage_thread(level.disable_super_in_turret.play_3p_anim_non_animscene._id_12039);
  else
    juggernaut_damage_thread(level.disable_super_in_turret.play_3p_anim_non_animscene.onplayerkilled);
}

pkg_lbl_vo() {
  var_0 = gettime();

  if(isDefined(self._id_11E76) && var_0 < self._id_11E76) {
    return;
  }
  var_1 = remove_flag_trig();
  var_2 = 1.0;
  var_3 = 0.5;
  var_4 = scripts\engine\math::lerp(var_2, var_3, var_1);
  self._id_11E76 = var_0 + int(1000 * var_4);

  if(var_1 <= 0) {
    return;
  }
  for(var_5 = 0; var_5 < level.disable_super_in_turret.setsuperisinuse.size; var_5++) {
    var_6 = level.disable_super_in_turret.setsuperisinuse[var_5]._id_13DB4;

    if(var_1 < var_6) {
      continue;
    }
    var_7 = level.disable_super_in_turret.play_3p_anim_non_animscene.clear_players_from_door_way_think[var_5];

    if(isDefined(var_7))
      self playlocalsound(var_7, self);

    var_8 = level.disable_super_in_turret.play_3p_anim_non_animscene._id_138AE[var_5];

    if(isDefined(var_8)) {
      if(!isDefined(self._id_11E77) || var_0 >= self._id_11E77) {
        self playlocalsound(var_8);
        self._id_11E77 = var_0 + int(1000 * randomfloatrange(3, 5));
      }
    }

    break;
  }
}

place_bad_place_until_flag(var_0) {
  if(getdvarint("_encstr_A51B2A6FF26E7F7ABAF71F8B62D937C92B2940A420786989B1934E3BE40D21236C5F4BD1DF78403FA8D7AB42", 0)) {
    return;
  }
  var_1 = remove_flag_trig();

  if(var_1 <= 0) {
    return;
  }
  for(var_2 = 0; var_2 < level.disable_super_in_turret.setsuperisinuse.size; var_2++) {
    var_3 = level.disable_super_in_turret.setsuperisinuse[var_2]._id_13DB4;

    if(var_0 <= var_3 && var_1 >= var_3) {
      var_4 = level.disable_super_in_turret.play_3p_anim_non_animscene._id_13B4A[var_2];

      if(isDefined(var_4))
        self playlocalsound(var_4, self);

      return;
    }
  }
}

lethal_crate_spawn() {
  if(!getdvarint("_encstr_BD3C1C6EC639D789E4EBCC95B093AF95DC859836B27D4656D9BE232716BB", 0)) {
    return;
  }
  if(isbot(self) || initmaxspeedforpathlengthtable(self)) {
    return;
  }
  if(isDefined(self.lethaldelayallows)) {
    return;
  }
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125EC()) {
    return;
  }
  var_0 = 200;
  var_1 = 250;
  self.lethaldelayallows = scripts\mp\hud_util::createprimaryprogressbar(var_0, var_1);
  self.letters = scripts\mp\hud_util::createprimaryprogressbartext(var_0 + 75, var_1 + 13);
  self.letters setvalue(0.0);

  if(getdvarint("_encstr_BA091E52E118D7A246C7EF8B81F82A25386BC1DED988A02A905F07F3831E439F", 0))
    self.lethal_equipmentmaskoffsets = scripts\mp\hud_util::createprimaryprogressbar(200, 235);

  thread level_respawn_func();
}

level_respawn_func() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = self.setarenaomnvarhealthtype;
  var_1 = distance(self.origin, self.setbrjuggsettings);

  for(;;) {
    var_2 = self.setarenaomnvarhealthtype;

    if(var_0 != var_2) {
      var_3 = var_2 / level.disable_super_in_turret.play_3p_anim_non_animscene._id_11B5E;

      if(var_3 > 1.0)
        var_3 = 1.0;

      self.lethaldelayallows scripts\mp\hud_util::updatebar(var_3, 0);
      var_0 = var_2;
      self.lethaldelayallows.bar.color = _encstr_8E222ECD6C4E96071DCD975B83CB7658B5AC3ABCE02BB9BC2627FACEE183FAD0B0638D57C6B4CD2C8ED2BDDC8BCEE6D8::level_ammo_crate_spawn();

      if(self.setbeingrevivedinternal >= level.disable_super_in_turret.play_3p_anim_non_animscene.gasmask_onpickupcreated)
        self.lethaldelayallows.color = (0.7, 0.3, 0.3);
      else
        self.lethaldelayallows.color = (0.5, 0.5, 0.5);

      self.letters setvalue(var_2);
    }

    if(getdvarint("_encstr_BA091E52E118D7A246C7EF8B81F82A25386BC1DED988A02A905F07F3831E439F", 0)) {
      var_4 = distance(self.origin, self.setbrjuggsettings);

      if(var_1 != var_4) {
        if(var_4 < level.disable_super_in_turret.play_3p_anim_non_animscene.gasgrenade_crate_player_at_max_ammo) {
          var_3 = min((level.disable_super_in_turret.play_3p_anim_non_animscene.gasgrenade_crate_player_at_max_ammo - var_4) / level.disable_super_in_turret.play_3p_anim_non_animscene.gasgrenade_crate_player_at_max_ammo, 1.0);
          self.lethal_equipmentmaskoffsets scripts\mp\hud_util::updatebar(var_3, 0);
          self.lethal_equipmentmaskoffsets.bar.color = (1, 0, 0);
        } else {
          var_3 = min((var_4 - level.disable_super_in_turret.play_3p_anim_non_animscene.gasgrenade_crate_player_at_max_ammo) / (level.disable_super_in_turret.play_3p_anim_non_animscene.gasgrenade_crate_spawn - level.disable_super_in_turret.play_3p_anim_non_animscene.gasgrenade_crate_player_at_max_ammo), 1.0);
          self.lethal_equipmentmaskoffsets scripts\mp\hud_util::updatebar(var_3, 0);
          self.lethal_equipmentmaskoffsets.bar.color = (1, 1, 1);
        }

        var_1 = var_4;
      }
    }

    waitframe();
  }
}