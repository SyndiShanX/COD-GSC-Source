/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_13209888df6eddf6.gsc
***********************************************/

#using scripts\core_common\flag_shared;
#using scripts\cp_common\dialogue;
#namespace namespace_a64c0f5b;

function main() {
  function_1e311986();
  level thread function_d7b0c8d8();
}

function function_1e311986() {}

function function_d7b0c8d8() {
  while(!isDefined(level.player)) {
    waitframe(1);
  }

  level thread function_3f615c45();
  level thread function_76a4e36f();
}

function function_3f615c45() {
  level flag::wait_till("flag_vo_intro_start");
  level thread function_f35873e3();
  level thread function_62380b23();
  level thread function_29c5050c();
  level thread function_d2c855c4();
  level thread function_1be22957();
}

function function_f35873e3() {
  level flag::wait_till("flag_vo_gearup_tent_1");
  level.vip endon(#"death");
  level.player endon(#"death");
  wait 1;
  level.vip dialogue::queue("vox_guid0d55ef7938644952ac3bc1ebc42a4714");
  wait 4;
  level.vip dialogue::queue("vox_guid8a4a50c5bdb749c0bcca8f1686f704fe");
  wait 7;
}

function function_62380b23() {
  level flag::wait_till("flag_vo_gearup_walk");
  level.vip endon(#"death");
  level.player endon(#"death");
  level.vip notify(#"cancel speaking");
  level.vip dialogue::queue("vox_guidafa9fd44b1f942b0b564d4b84e6b5488", undefined, 1);
  level.vip dialogue::queue("vox_guid9785da2a4352473c91d22018a0e97712");
  level flag::wait_till("flag_vo_gearup_walk_pt2");
  level.vip notify(#"cancel speaking");
  level.vip dialogue::queue("vox_guidff248d77fd774311a56e085552da8683", undefined, 1);
  level flag::wait_till("flag_vo_gearup_walk_pt3");
  level.vip notify(#"cancel speaking");
  level.vip dialogue::queue("vox_guid7d8d91782194471d949d8bbf894c27ce", undefined, 1);
}

function function_29c5050c() {
  level endon(#"flag_intro_player_boarded_chopper");
  var_6aa6a4ac = [];

  while(true) {
    delay = 10;
    level flag::wait_till("flag_vo_intro_walk_and_talk_nags");
    var_29a0fa27 = 0;

    if(level flag::get("flag_intro_adler_walk_talk_pos_2")) {
      var_6aa6a4ac = ["vox_cp_armd_00002_adlr_dammitbellgotta_57"];
    } else if(level flag::get("flag_intro_adler_walk_talk_pos_1")) {
      var_6aa6a4ac = ["vox_cp_armd_00002_adlr_gotagoodfeeling_18", "vox_cp_armd_00002_adlr_whatyoustillasl_40"];
    } else {
      var_6aa6a4ac = ["vox_cp_armd_00002_adlr_stillwithmebell_e0", "vox_cp_armd_00002_adlr_comeonbellwegot_df"];
    }

    wait 15;

    while(flag::get("flag_vo_intro_walk_and_talk_nags") && var_29a0fa27 < var_6aa6a4ac.size) {
      if(soundexists(var_6aa6a4ac[var_29a0fa27]) && !is_true(level.vip.istalking)) {
        level.vip dialogue::queue(var_6aa6a4ac[var_29a0fa27]);
      }

      var_29a0fa27++;
      wait delay;
      delay *= 2;
    }

    level flag::wait_till_clear("flag_vo_intro_walk_and_talk_nags");
  }
}

function function_d2c855c4() {
  level flag::wait_till("flag_vo_gearup_reach_chopper");
  level notify(#"hash_227cc8ce5802e6b5");
  level.vip endon(#"death");
  level.player endon(#"death");
  level.vip dialogue::queue("vox_guide3db1a89d09945f7a738f5ab68ccedbb");
  level.vip dialogue::queue("vox_guid9878c3fea71449bba4993aef2889fd19");
  level.vip dialogue::queue("vox_guid66680df081fc40f285943349d13e938d");
  level.vip dialogue::queue("vox_guida0ebfd87a32e479cac481da40d5c5cc1");
  level.vip dialogue::queue("vox_guidb99bdcf7afc746c9a36a0bf8245e8ed9");
  level.vip dialogue::queue("vox_guida951b1e55fa64cf9be5603097c000c89");
}

function function_1be22957() {
  level.player endon(#"death");
  level flag::wait_till("flag_vo_chopper_chatter_1");
  level.player dialogue::queue("vox_cp_arma_gear_ctrl_allbirdscheckinwhenr");
  wait 1;
  level.player dialogue::queue("vox_guide0723b18a432467aaadbe181eb8786b7");
  wait 1;
  level.player dialogue::queue("vox_guidcf109981d1604468a2b623f7c660b854");
  wait 1;
  level.player dialogue::queue("vox_guideb9c659f403b4255ae0df5ea1f8bded1");
  level flag::wait_till("flag_vo_chopper_chatter_2");
  level.player dialogue::queue("vox_guidcd1d9084043141379fdb6cb64d19a474");
  wait 6;
  level.player dialogue::queue("vox_cp_arma_gear_nava_whadayaknowsims");
  wait 0.5;
  level.player dialogue::queue("vox_guid67745166784c4fbba4bb36b5933a05a1");
  wait 0.5;
  level.gunner dialogue::queue("vox_cp_arma_gear_nava_rogerthat");
}

function function_76a4e36f() {
  level.player endon(#"death");
  level flag::wait_till("flag_vo_chopper_chatter_3");
  level.player dialogue::queue("vox_cp_arma_gear_chp2_thirtysecondstoripco");
  level.player dialogue::queue("vox_guid58903da3ed934d5a8a2c1eec17d7d0f0");
}

function function_78e24143() {}

function function_7b81dbaa() {
  level.player endon(#"death");
  level endon(#"hash_7d003f32d8dd699d");
  level flag::wait_till("flag_vo_firebase_arrival_pull_up");
  level notify(#"hash_4138703eb9baf09c");
  level.player notify(#"cancel speaking");
  level.player dialogue::function_47b06180();
  level.player dialogue::queue("vox_guidab3401285e7a4c918b3539e8e3a1d28f");
  level.player dialogue::queue("vox_guidb4c607e841f041d788787ec1b5415094");
  level.player dialogue::queue("vox_guid224bfadb4f4049a9962b422b16da5c4c");
  level.player dialogue::queue("vox_guid6c06d12257ca4c3ba9e63630c5b19971");
  level.player dialogue::queue("vox_cp_arma_fbch_chp2_skyoutskyout");
  level flag::wait_till("flag_vo_firebase_arrival_stabilize");
  level.player dialogue::queue("vox_guidefa6428faae1410bbf01238a4c0e468c");
  wait 1;
  level.player dialogue::queue("vox_cp_arma_fbch_sims_wherethehellrethosec");
  level.player dialogue::queue("vox_cp_arma_fbch_chpt_lookslikenortheastbo");
  wait 1;
  level.player dialogue::queue("vox_cp_arma_fbch_adlr_canyougetusthere");
  level.player dialogue::queue("vox_cp_arma_fbch_chpt_yessir");
  level.player dialogue::queue("vox_cp_arma_fbch_adlr_ripcordwhatsyourstat");
  level.player dialogue::queue("vox_cp_arma_fbch_amc2_assetsbackinthebunke");
  level.player dialogue::queue("vox_guida30faf3b12434785a3b89c4b1cd1d180");
  level.player dialogue::queue("vox_guidc29b74bfd710458695eab62b4724a276");
  wait 0.75;
  level.player dialogue::queue("vox_guid92c5e0e86009462c82527fc481ca72aa");
  level.player dialogue::queue("vox_guida3960afa27f749c89472cf2d8d1824cd");
  wait 0.5;
  level.player dialogue::queue("vox_guide1f9a5eeda874f628919db39871dbcfd");
  level.player dialogue::queue("vox_guidb31a969d47a84950969a620cb0268d56");
  wait 1;
  level flag::set("flag_vo_firebase_arrival_stabilize_complete");
}

function function_db399e7() {
  level.player endon(#"death");
  thread function_c2808184();
  thread function_1db51e3c();
  thread function_9a288202();
  flag::wait_till("flag_vo_mortar_orbit_landing_requested");
  level.player notify(#"cancel speaking");
  function_26af2826();
  level flag::set("flag_vo_mortar_arrival_orbit_complete");
}

function function_c2808184() {
  level.player endon(#"death");

  if(level flag::get("flag_mortar_village_complete")) {
    return;
  }

  flag::wait_till("flag_vo_fly_in_mortar_village_sighted");
  level.player notify(#"cancel speaking");
  level.player dialogue::queue("vox_guid72539f2b1d6947399b1d9533a0601c69");
  level.player dialogue::queue("vox_guid3a94c8c66e284940b25a23eeda521d25");

  if(level flag::get("flag_bamboo_end_end")) {
    level.player dialogue::queue("vox_guid330f35ba3e454839a66c4b9bfffb6929");
  } else {
    level.player dialogue::queue("vox_guidf657fbb91fa448199f3d006f9c015c6c");
    level.player dialogue::queue("vox_guid941d4c98b1f2481090dc318a582d671d");
    level.player dialogue::queue("vox_guide199ba5754da40d1a70d990584dc10bf");
  }

  level.player dialogue::queue("vox_guidc71c9b8ab7af4f2ab3e27badda0abcf1");
  level.player dialogue::queue("vox_guid72c3f5afdea74811934924a1e1a413f2");
  level flag::wait_till("flag_vo_mortar_orbit_arrival_start");
}

function function_1db51e3c() {
  level endon(#"hash_a3faf07853176cf");
  level.player endon(#"death");
  level endon(#"flag_vo_mortar_orbit_landing_requested");

  while(true) {
    level waittill(#"hash_3eb3c24dcfb40680");

    if(level.var_74bc4f87 == 1) {
      level.player dialogue::queue("vox_guid209f24c873734908b0ad786d93b17272");
    } else if(level.var_74bc4f87 == 2) {
      level.player dialogue::queue("vox_guid2261c2948feb4164bb989eb4dceaa1f1");
    } else if(level.var_74bc4f87 == 3) {
      if(level flag::get("flag_bamboo_end_end")) {
        level.player dialogue::queue("vox_guid657ffe94d4c047b584f7a283e35815e4");
        level.player dialogue::queue("vox_guid725c30a8efdd445faa5731684412fc9c");
        level.player dialogue::queue("vox_guidb23591f109dc4fb483791e6791edfa25");
        level.player dialogue::queue("vox_guide199ba5754da40d1a70d990584dc10bf");
        level.player dialogue::queue("vox_guid00d9f4a2b22e436a88df32cb79c9bb5a");
        level.player dialogue::queue("vox_guid6e4f40df7fb742c3a7359a9d031a83d9");
        level.player dialogue::queue("vox_guidd75430dc813a424c89668933c2310ba9");
      } else {
        level.player dialogue::queue("vox_guid657ffe94d4c047b584f7a283e35815e4");
        level.player dialogue::queue("vox_guid725c30a8efdd445faa5731684412fc9c");
        level.player dialogue::queue("vox_guidb23591f109dc4fb483791e6791edfa25");
        level.player dialogue::queue("vox_guida9dd80499b2d4573bc3b1b1de772da1c");
        level.player dialogue::queue("vox_guid00d9f4a2b22e436a88df32cb79c9bb5a");
        level.player dialogue::queue("vox_guid62bed88df96840ce875c98e28a9dc3a2");
        level.player dialogue::queue("vox_guid5109b657eb77422a805625671687bde4");
        level.player dialogue::queue("vox_guidc1f77a0bd64c4ba8af0f16a1075b0411");
        level.player dialogue::queue("vox_guid11048d07bae54138a19db03026d08647");
        level.player dialogue::queue("vox_guidd75430dc813a424c89668933c2310ba9");
        level.player dialogue::queue("vox_guid5f7f76352bc04401bc94a0d6c9bfce35");
      }
    } else if(flag::get("flag_vo_mortar_orbit_mortar_flee")) {
      level.player thread dialogue::queue("vox_guid25b1be22d2e54d4cab0bb67731962814");
    } else {
      level.player thread dialogue::queue("vox_guidf7e4e68765b94536af3c9c24ec79b1d2");
    }

    waitframe(1);
  }
}

function function_26af2826() {
  self endon(#"death");

  if(level flag::get("flag_bamboo_end_end")) {
    level.player dialogue::queue("vox_guide2ada7c1ba4944458fcff61778cf4d40");
    level.player dialogue::queue("vox_guida41a493a444c4224b652d47531fc8fd4");
  } else {
    level.player dialogue::queue("vox_guid1e6afdfc9ec54ec6acaa19fe201e9946");
    level.player dialogue::queue("vox_guide7f56fd2d78c43f198185f8a10c5ee3a");
    level.player dialogue::queue("vox_guida41a493a444c4224b652d47531fc8fd4");
  }

  flag::wait_till("flag_mortar_orbit_rappel_start");
  level.player dialogue::queue("vox_guid63b02a4a2947468087df8a36913c3c95");
}

function function_9a288202() {
  level.player endon(#"death");
  trig = getent("mortar_orbit_building_upper_trig", "targetname");

  while(flag::get("flag_mortar_orbit_rappel_start")) {
    trig waittill(#"trigger");
    level.player dialogue::queue("vox_guidc74ff5e22c4048b9a8903e1a27fe402c");
    wait 8;
  }
}

function function_c3e6affa() {
  level flag::wait_till("flag_vo_mortar_arrival_orbit_complete");

  if(level flag::get("flag_bamboo_end_end")) {
    level.player dialogue::queue("vox_guid289ff1929f3c4b01a6da416650207617");
    level.player dialogue::queue("vox_guidfba2d09205c4430493ab2056dd3953f0");
    level.player dialogue::queue("vox_guid0f1d012fdbda41fda6e2f41fb93e82c4");
    level.player dialogue::queue("vox_guid11a4904a82934db6805a56e7ba5bd307");
  } else {
    level.player dialogue::queue("vox_guid289ff1929f3c4b01a6da416650207617");
    level.player dialogue::queue("vox_guid34fbba336c1347bea64d39e02ebe18b2");
    level.player dialogue::queue("vox_guidb558749c8a01404bbb0ff3b6c6af6d6c");
    level.player dialogue::queue("vox_guid11a4904a82934db6805a56e7ba5bd307");
  }

  level thread function_5c799650();
  level thread function_6521d173();
  level thread function_7cfd201b();
  level thread function_c21dbdb6();
}

function function_7cfd201b() {}

function function_c21dbdb6() {
  level.player endon(#"death");
  level waittill(#"forever");
  level.player dialogue::queue("vox_guidfa5debdca11a4e18bc9b789272c4b74e");
  level.buddy dialogue::queue("vox_guida2254816817745308deb629336a54cdd");

  if(flag::get("flag_bamboo_end_end")) {
    level.player dialogue::queue("vox_guid6e9f47d78e5d4e5886aa80268e2ff25e");
  } else {
    level.player dialogue::queue("vox_guid903b362f680d4194b568510526c52f36");
  }

  level.buddy dialogue::queue("vox_guid958573b2b55448979628bce4d222884e");
}

function function_5c799650() {
  level.player endon(#"death");
  level flag::wait_till("flag_vo_mortar_main_building_entrance");
  level.player dialogue::queue("vox_guidfb22606e4b0645db935d12aecd0128c3");
  level flag::wait_till("flag_vo_rus_mortar_spotted");
  level.player dialogue::queue("vox_guid6ff5b83a08c146c7a5ff1f1174cbd4cc");
  level flag::wait_till("obj_flag_mortar_site_a");
  level.player dialogue::queue("vox_guida55a9b9383ae409c9377280bf55066d3");
  level.player dialogue::queue("vox_guide060736f9df24af792e4ff2c102a7d68");
  level.player dialogue::queue("vox_guiddcb45ef4cfaa425a82d7045386c0dee8");
  level.player dialogue::queue("vox_guid693229f797854424a540b9053464212b");
}

function function_6521d173() {
  level.player endon(#"death");
  level flag::wait_till("flag_vo_rus_mortar_exfil_door");
  level.player dialogue::queue("vox_guid7ac5e718078f497183164d5e3ac649e5");
  level.player dialogue::queue("vox_guid70c86067960141a4b1b5fcad48759614");
  level waittill(#"hash_78f5eb15e6763d58");
  level.player dialogue::queue("vox_guid4e92b2d194754432b5685887f600f388");
  level.player dialogue::queue("vox_guidaca2954c1d8c4eea8564cc19fbc84ac6");
  level waittill(#"hash_58cbd171da71efd6");
  level.player notify(#"cancel speaking");

  if(level flag::get("flag_bamboo_end_end")) {
    level.player dialogue::queue("vox_guidb87c681624754cf2a870757a5888ea34");
    level.player dialogue::queue("vox_guid35110a2bf890418798b0b53cb92b7d30");
    level.player dialogue::queue("vox_guidfe709e34725a4b27a6e83696408efb39");
  } else {
    level.player dialogue::queue("vox_guid957aaad03c0d4168ab80dbc1f51e66cf");
    level.player dialogue::queue("vox_guid9a5feca98a7641b48fdc612815283908");
  }

  level flag::set("mortar_vo_complete");
}

function function_fa2426a0() {}

function function_8992adb2() {
  level.player endon(#"death");
  level endon(#"flag_vo_firebase_orbit_return_start");
  level flag::wait_till_any(["flag_vo_bamboo_firebase_start", "flag_vo_mortar_firebase_start"]);

  if(!level flag::get("flag_mortar_village_complete")) {
    return;
  }

  level.player dialogue::queue("vox_guide1bbca61b63342268117e60b887e85fa");
  wait 0.5;
  level.player dialogue::queue("vox_guid423a565786384dae9665c74dffa96979");
  wait 0.5;
  level.player dialogue::queue("vox_guidea1efdce6a284218a9b35f38ea0b898d");
  wait 0.5;
  level.player dialogue::queue("vox_guid5baf7a3a01d84bfd9493e4bdac942f25");
  wait 0.5;
  level.player dialogue::queue("vox_guid0868acc8edb84b729559c7f7600e532b");
  wait 0.5;
  level.player dialogue::queue("vox_guid0249abe5a5094b528a75433f8133729c");
  wait 0.5;
  level.player dialogue::queue("vox_guida49455032d554b4c9c694eeee07a93b3");
  wait 0.5;
  level.player dialogue::queue("vox_guide8596c149b834987a5dbe7620de96de3");
  level flag::wait_till("flag_vo_firebase_return_mid_point");
  level.player dialogue::queue("vox_guidf71215c125de46ed8129ae501cb0ac67");
  wait 0.5;
  level.player dialogue::queue("vox_guidfc1aa539957b49aa842d318f6ddaf986");
  wait 0.5;
  level.player dialogue::queue("vox_guid077340e5bb6a42fe967ffc2ef5ef237a");
}

function function_1a1a9bab() {
  level flag::wait_till("flag_vo_firebase_orbit_return_start");
  level thread function_c7676f8d();
  wait 1;
  level.players[0] dialogue::queue("vox_guid692a7045854a4ba48697c2dbcca61d5d");
  level.players[0] dialogue::queue("vox_guidcd67f052c15c47fc96de92b3676c473e");
  level.players[0] dialogue::queue("vox_guida2a3ef6f5b5d48c3b24de59e9f92194f");
  level.players[0] dialogue::queue("vox_guid0b9e15780e71488ea12d96e4b847cc14");
  level.players[0] dialogue::queue("vox_guidb42a1504c0554dd4bd12da8b8f5e4b17");
  wait 2;
}

function function_c7676f8d() {
  level flag::wait_till("flag_vo_firebase_asset_reveal");
  level.vip dialogue::queue("vox_guid7faa052547a14004bca281a48c6566e1");
  level.player dialogue::queue("vox_guid71bc64a458da4f8f93da59af6e3c40a5");
  level.player dialogue::queue("vox_guid65c2dd2a98c24282a7a36c7ae9025405");
  level.player dialogue::queue("vox_guidd5354e1814494025871a00aa5a5414c6");
  level.player dialogue::queue("vox_guid7b107f991b9d4f0da4f600f3812cfa9c");
  level.player dialogue::queue("vox_guid214b4736bb0d4364b9989c614b81daed");
  level.player dialogue::queue("vox_guidecd3f79a98384a78b5e18b5a25cc8452");
  level.player dialogue::queue("vox_guid3617a5bb65ec498d82133a83d7b2560e");
  level.player dialogue::queue("vox_guidfc3487dc9c9345478c0754c4982d4b60");
  level.player dialogue::queue("vox_guidfc675b8bf2d047eeb7104f86c64c07a5");
  level.player dialogue::queue("vox_guid7ac045bc8aad41449a35a0541b0a1a14");
  level.player dialogue::queue("vox_guid3e3aaf7814c04d549e3b18721435b9fa");
}

function add_dialogue_line(name, msg, var_733709e8, duration = 8) {
  if(getdvarint(#"loc_warnings", 0)) {
    return;
  }

  if(getdvarint(#"hash_40d0919a4a1cc0fc", 1) == 0) {
    return;
  }

  if(!isDefined(level.dialogue_huds)) {
    level.dialogue_huds = [];
  }

  if(level.dialogue_huds.size == 5) {
    oldhud = level.dialogue_huds[0];
    arrayremoveindex(level.dialogue_huds, 0, 1);
    update_dialogue_huds();
    oldhud thread destroy_dialogue_hud();
  }

  color = "<dev string:x38>";

  if(isDefined(var_733709e8)) {
    switch (var_733709e8) {
      case # "red":
      case # "r":
        color = "<dev string:x3e>";
        break;
      case # "green":
      case # "g":
        color = "<dev string:x44>";
        break;
      case # "yellow":
      case # "y":
        color = "<dev string:x38>";
        break;
      case # "b":
      case # "blue":
        color = "<dev string:x4a>";
        break;
      case # "c":
      case # "cyan":
        color = "<dev string:x50>";
        break;
      case # "purple":
      case # "p":
        color = "<dev string:x56>";
        break;
      case # "w":
      case # "white":
        color = "<dev string:x5c>";
        break;
      case # "bl":
      case # "black":
        color = "<dev string:x62>";
        break;
    }
  }

  scale = 1;

  if(isDefined(level.dialoguelinescale)) {
    scale = level.dialoguelinescale;
  }

  hud = newdebughudelem();
  hud.elemtype = "<dev string:x68>";
  hud.font = "<dev string:x70>";
  hud.fontscale = scale;
  hud.x = 0;
  hud.y = 0;
  hud.horzalign = "<dev string:x7b>";
  hud.width = 0;
  hud.height = int(level.fontheight * scale);
  hud.xoffset = 0;
  hud.yoffset = 0;
  index = level.dialogue_huds.size;
  level.dialogue_huds[index] = hud;
  hud.foreground = 1;
  hud.sort = 20;
  hud.x = 20;
  hud.y = 260 + index * 12 * scale;
  hud settext("<dev string:x83>" + color + name + "<dev string:x87>" + msg);
  hud.alpha = 0;
  hud fadeovertime(0.2);
  hud.alpha = 1;
  hud endon(#"death");
  wait duration;
  arrayremovevalue(level.dialogue_huds, hud);
  update_dialogue_huds();
  hud thread destroy_dialogue_hud();
}

function private destroy_dialogue_hud() {
  scale = 1;

  if(isDefined(level.dialoguelinescale)) {
    scale = level.dialoguelinescale;
  }

  self endon(#"death");
  self fadeovertime(0.2);
  self moveovertime(0.2);
  self.y -= 12 * scale;
  self.alpha = 0;
  wait 0.2;
  self destroy();
}

function private update_dialogue_huds() {
  scale = 1;

  if(isDefined(level.dialoguelinescale)) {
    scale = level.dialoguelinescale;
  }

  arrayremovevalue(level.dialogue_huds, undefined);

  foreach(index, hud in level.dialogue_huds) {
    hud moveovertime(0.2);
    hud.y = 260 + index * 12 * scale;
  }
}