/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_14fb718749afd7cf.gsc
*************************************************/

#using script_3054293078dbc58c;
#using script_3badb8914eb5ac16;
#using script_4c543f01345a2c04;
#using script_7edf952f8921aa6b;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\asm\shared\variant_asm;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_973ff0e125d70907;

function private function_f49a30f92555b827() {}

function function_a53f4a78a75cbd41(params) {
  function_6e4961e4c0a38088(params);
  function_2fb78e9231f86523(params);
}

function function_813f575ebec2810e(asmname, statename, params) {
  function_a343ac31ca854535(&function_f49a30f92555b827);
  self.asm.footsteps = spawnStruct();
  self.asm.footsteps.foot = "invalid";
  self.asm.footsteps.time = 0;
  self.asm.customdata = spawnStruct();
  function_1e6c26c524ac2fe0();
  function_7924cc8cc6bf34fb();
  function_a2a77fce983ed84f();
  function_7ec7570ece16298c();
  function_3ac9a98e8b6202d6();
  function_a49fd15fdc5e36d();
  function_5fef44b6310a75b9();
  asm_setmoveplaybackrate(1);
  callback::add("on_ai_init", &on_ai_init);
  ent_flag_set("zombie_asm_init_finished");
  thread function_a872fb483eb16ecd();
}

function private on_ai_init(params) {
  callback::remove("on_ai_init", &on_ai_init);
}

function on_move_speed_changed(params) {
  self.var_30158902d2e2c3c0 = self aigetdesiredspeed();
}

function private function_95ff51aa0e485240(settings, phaseindex) {
  if(!isDefined(self.phasedata[phaseindex])) {
    self.phasedata[phaseindex] = spawnStruct();
  }

  self.phasedata[phaseindex].var_8d5f6ee9e22c653e = [];
  self.phasedata[phaseindex].healthscriptbundle = settings.var_47968b563c144dc;
  self.phasedata[phaseindex].var_9cfdfb806b41190c = settings.var_9cfdfb806b41190c;
  self.phasedata[phaseindex].var_9cfdfb806b41190c.var_72b6da1531fbd71d = settings.var_9cfdfb806b41190c.var_72b6da1531fbd71d * 1000;
  self.phasedata[phaseindex].var_43e413695b603f76 = 0;
}

function function_1e6c26c524ac2fe0() {
  function_95ff51aa0e485240(self.zombieaisettings.var_e58a65b7a8f5973c.var_f4729d0569e460b8, 0);
  function_95ff51aa0e485240(self.zombieaisettings.var_e58a65b7a8f5973c.var_3c9964059ea30c5e, 1);
  function_95ff51aa0e485240(self.zombieaisettings.var_e58a65b7a8f5973c.var_5a24dc6495846e22, 2);
}

function function_7924cc8cc6bf34fb() {
  var_1aae636c7b2bc674 = self.zombieaisettings.var_e58a65b7a8f5973c.var_1aae636c7b2bc674;
  self.attackdata = spawnStruct();
  self.attackdata.var_9540d52e669b0713 = var_1aae636c7b2bc674.var_9540d52e669b0713;
  self.attackdata.var_ea825821af5f56f1 = var_1aae636c7b2bc674.var_ea825821af5f56f1;
}

function function_6e4961e4c0a38088(params) {
  settings = zombie_utils::function_cb7771bf461049eb(params);

  if(isDefined(settings)) {
    add_fx("entity_beam_vfx" + "phase1", settings.var_bd43ea367f2d9067.var_b33910d3fd7718b1[0].var_4b3afacf12234a5b);
    add_fx("entity_beam_origin_vfx" + "phase1", settings.var_bd43ea367f2d9067.var_b33910d3fd7718b1[0].var_5902ec8cf43f0c51);
    add_fx("entity_tracker_beam_vfx" + "phase1", settings.var_bd43ea367f2d9067.var_b33910d3fd7718b1[0].var_5547a31b73b31d5b);
    add_fx("entity_beam_vfx" + "phase2", settings.var_bd43ea367f2d9067.var_b33910d3fd7718b1[1].var_4b3afacf12234a5b);
    add_fx("entity_beam_origin_vfx" + "phase2", settings.var_bd43ea367f2d9067.var_b33910d3fd7718b1[1].var_5902ec8cf43f0c51);
    add_fx("entity_tracker_beam_vfx" + "phase2", settings.var_bd43ea367f2d9067.var_b33910d3fd7718b1[1].var_5547a31b73b31d5b);
  }
}

function function_a2a77fce983ed84f() {
  self.var_a3d0ad660af72d52 = spawnStruct();
  self.var_a3d0ad660af72d52.starttime = 0;
  self.var_a3d0ad660af72d52.targetent = undefined;
  var_bd43ea367f2d9067 = self.zombieaisettings.var_e58a65b7a8f5973c.var_bd43ea367f2d9067;
  self.var_a3d0ad660af72d52.specialdamage = var_bd43ea367f2d9067.var_b24ef2f9dac18bfd;
  self.var_a3d0ad660af72d52.var_6004242b2a8e2529 = var_bd43ea367f2d9067.var_476a4b2a066d4671;
  self.var_a3d0ad660af72d52.var_e3283b87da5f2e91 = var_bd43ea367f2d9067.var_676d47107de72f79;
  self.var_a3d0ad660af72d52.var_59ce2c6601dbb32e = var_bd43ea367f2d9067.var_5543a6f90d25f1e;
  self.var_a3d0ad660af72d52.var_b33910d3fd7718b1 = [];
  function_aa8ec532474634a0(var_bd43ea367f2d9067.var_b33910d3fd7718b1[0], 0);
  function_aa8ec532474634a0(var_bd43ea367f2d9067.var_b33910d3fd7718b1[1], 1);
  function_aa8ec532474634a0(var_bd43ea367f2d9067.var_b33910d3fd7718b1[2], 2);
}

function function_aa8ec532474634a0(settings, index) {
  if(!isDefined(self.var_a3d0ad660af72d52.var_b33910d3fd7718b1[index])) {
    self.var_a3d0ad660af72d52.var_b33910d3fd7718b1[index] = spawnStruct();
  }

  self.var_a3d0ad660af72d52.var_b33910d3fd7718b1[index].disabled = settings.disable;
  self.var_a3d0ad660af72d52.var_b33910d3fd7718b1[index].playerdamage = settings.var_d549f0ad66311315;
  self.var_a3d0ad660af72d52.var_b33910d3fd7718b1[index].var_136749637cbe9ad2 = settings.var_db1efa5d79424809 * 1000;
  self.var_a3d0ad660af72d52.var_b33910d3fd7718b1[index].var_68e04b0455c43bfe = settings.var_110116ebbf6b2591 * 1000;
  self.var_a3d0ad660af72d52.var_b33910d3fd7718b1[index].cooldown = settings.var_d8db7225901f66f4 * 1000;
  self.var_a3d0ad660af72d52.var_b33910d3fd7718b1[index].var_591cbe2e14d189c0 = settings.var_12033ee94f9c5579;
  self.var_a3d0ad660af72d52.var_b33910d3fd7718b1[index].var_4be7b82edbfe5a31 = settings.var_a58440e784566928;
  self.var_a3d0ad660af72d52.var_b33910d3fd7718b1[index].handtag = "tag_accessory_right";
  self.var_a3d0ad660af72d52.var_b33910d3fd7718b1[index].var_15c62e2a3e84a52 = settings.var_5f4dde0a325d5c29;
  self.var_a3d0ad660af72d52.var_b33910d3fd7718b1[index].var_e4fbe8b46e55aabc = settings.var_f004de91f9c2a1d7;
  self.var_a3d0ad660af72d52.var_b33910d3fd7718b1[index].var_9ed08423c48f77a = settings.var_f592239c6e4e61a1;
  self.var_a3d0ad660af72d52.var_b33910d3fd7718b1[index].var_856dc80728272d7b = settings.var_856dc80728272d7b;
  self.var_a3d0ad660af72d52.var_b33910d3fd7718b1[index].var_2bf0e4c391a41f48 = settings.var_2bf0e4c391a41f48;
}

function function_6bbee6a93e3e230a(asmname, statename, params) {
  thread function_ff006432bac51fc8();
}

function private function_ff006432bac51fc8() {
  level endon("game_ended");
  self endon("death");
  self endon("fake_death");
  self endon("beam_end");
  self endon("beam_attack_end");
  self waittill("beam_origin_start");
  ent_flag_set("beam_origin_start");
}

function function_8cb14da1ff370334(asmname, statename, params) {
  self.var_a3d0ad660af72d52.var_ba5f72633d21887d = gettime();
  self function_3e89eb3d8e3f1811("in_beam_attack", 2);
  thread function_8514be9013db37d();
}

function private function_8514be9013db37d() {
  level endon("game_ended");
  self endon("death");
  self endon("beam_end");
  self endon("beam_attack_end");
  self waittill("start_beam");
  function_63e5b8e4b592a4f1();
  self waittill("end_beam");
  ent_flag_set("end_beam");
}

function function_63e5b8e4b592a4f1(asmname, statename, params) {
  self.var_a3d0ad660af72d52.var_8b3564d3aa8cefe2 = gettime();
  self function_3e89eb3d8e3f1811("in_beam_attack", 4);
}

function function_79f2f5d7ff64e961(asmname, statename, params) {
  self function_3e89eb3d8e3f1811("in_beam_attack", 6);
}

function function_2fb78e9231f86523(params) {
  settings = zombie_utils::function_cb7771bf461049eb(params);

  if(isDefined(settings)) {
    add_fx("entity_lightning_charge_vfx", settings.var_ef63af26bd5b3bbe.var_fef4c1427aeb4b3f);
    add_fx("entity_lightning_vfx", settings.var_ef63af26bd5b3bbe.var_766b6bb25e30c44b);
    add_fx("entity_lightning_impact_vfx", settings.var_ef63af26bd5b3bbe.var_32801f05296e71d1);
  }
}

function private function_5e033c1c4062e0c3(settings, phaseindex) {
  self.var_730fcb57528054fb.phase[phaseindex] = spawnStruct();
  self.var_730fcb57528054fb.phase[phaseindex].disabled = settings.disable;
  self.var_730fcb57528054fb.phase[phaseindex].type = settings.var_6369b79bc4304fcf.var_b0f165e4b392440b;
  self.var_730fcb57528054fb.phase[phaseindex].numlocations = settings.var_6369b79bc4304fcf.numlocations;
  self.var_730fcb57528054fb.phase[phaseindex].numstrikes = settings.var_6369b79bc4304fcf.numstrikes;
  self.var_730fcb57528054fb.phase[phaseindex].cooldown = settings.var_6369b79bc4304fcf.var_ba92d7476ad36306 * 1000;
  self.var_730fcb57528054fb.phase[phaseindex].chargetime = settings.var_6369b79bc4304fcf.var_6ca3b9f14c0bf09a * 1000;
  self.var_730fcb57528054fb.phase[phaseindex].var_8eee116faeee52e0 = min(settings.var_6369b79bc4304fcf.var_6ca3b9f14c0bf09a, settings.var_6369b79bc4304fcf.var_b7744d44b88709b2) * 1000;
  self.var_730fcb57528054fb.phase[phaseindex].var_700e02b386c08562 = settings.var_6369b79bc4304fcf.var_700e02b386c08562 * 1000;
  self.var_730fcb57528054fb.phase[phaseindex].var_253536622d01ef2 = settings.var_6369b79bc4304fcf.var_253536622d01ef2;

  if(isDefined(settings.var_bb5766c50cade782) && settings.var_bb5766c50cade782.size > 0) {
    self.var_730fcb57528054fb.phase[phaseindex].var_8992397197cec28a = settings.var_bb5766c50cade782[0];
    self.var_730fcb57528054fb.phase[phaseindex].var_8992397197cec28a.type = settings.var_bb5766c50cade782[0].variant_object.var_5718407c4bbd7052;
    return;
  }

  self.var_730fcb57528054fb.phase[phaseindex].var_8992397197cec28a = spawnStruct();
  self.var_730fcb57528054fb.phase[phaseindex].var_8992397197cec28a.type = "InstantKill";
}

function function_7ec7570ece16298c() {
  self.var_730fcb57528054fb = spawnStruct();
  self.var_730fcb57528054fb.starttime = 0;
  self.var_730fcb57528054fb.phase = [];
  var_e90fa9172db4145 = self.zombieaisettings.var_e58a65b7a8f5973c.var_f4729d0569e460b8.var_ef63af26bd5b3bbe;
  function_5e033c1c4062e0c3(var_e90fa9172db4145, 0);
  var_d353b5cd8fecf9eb = self.zombieaisettings.var_e58a65b7a8f5973c.var_3c9964059ea30c5e.var_ef63af26bd5b3bbe;
  function_5e033c1c4062e0c3(var_d353b5cd8fecf9eb, 1);
  var_257ff921d827df07 = self.zombieaisettings.var_e58a65b7a8f5973c.var_5a24dc6495846e22.var_ef63af26bd5b3bbe;
  function_5e033c1c4062e0c3(var_257ff921d827df07, 2);
}

function private function_1b4319a3c42c90f6(settings, phaseindex) {
  self.var_e198ad98b4845f29.phase[phaseindex] = spawnStruct();
  self.var_e198ad98b4845f29.phase[phaseindex].var_e585ee0d361fb9ba = settings.var_c07f83a0ce7c72b9;
  self.var_e198ad98b4845f29.phase[phaseindex].var_43d7f127229729e1 = settings.var_43d7f127229729e1;
  self.var_e198ad98b4845f29.phase[phaseindex].var_184af0c1a8b292d2 = settings.var_184af0c1a8b292d2;
  self.var_e198ad98b4845f29.phase[phaseindex].var_2a032a8d81704ebe = settings.var_2a032a8d81704ebe;
  self.var_e198ad98b4845f29.phase[phaseindex].var_e1feaafebeaf442a = settings.var_e1feaafebeaf442a;
  self.var_e198ad98b4845f29.phase[phaseindex].var_f88e5ea025599288 = settings.var_f88e5ea025599288;
}

function function_3ac9a98e8b6202d6() {
  self.var_e198ad98b4845f29 = spawnStruct();
  self.var_e198ad98b4845f29.phase = [];
  self.var_e198ad98b4845f29.var_a478985793711972 = 0;
  var_e90fa9172db4145 = self.zombieaisettings.var_e58a65b7a8f5973c.var_f4729d0569e460b8.var_806b98b1cc6d3e4f;
  function_1b4319a3c42c90f6(var_e90fa9172db4145, 0);
  var_d353b5cd8fecf9eb = self.zombieaisettings.var_e58a65b7a8f5973c.var_3c9964059ea30c5e.var_806b98b1cc6d3e4f;
  function_1b4319a3c42c90f6(var_d353b5cd8fecf9eb, 1);
  var_257ff921d827df07 = self.zombieaisettings.var_e58a65b7a8f5973c.var_5a24dc6495846e22.var_806b98b1cc6d3e4f;
  function_1b4319a3c42c90f6(var_257ff921d827df07, 2);
  self.var_e198ad98b4845f29.var_c9a5e91aaf4191d5 = self.maxhealth;
  function_e76e619513257747();
}

function function_d9b19199b8318d74(asmname, statename, params) {
  self endon(statename + "_finished");
  var_da73a84926b8be73 = self asmgetanim(asmname, statename);
  self aisetanim(statename, var_da73a84926b8be73, 1);
  function_371b90eded88e54d(asmname, statename, "warp_backward_start", "warp_backward_end", 50, 1);
}

function function_e76e619513257747() {
  var_137aadf13edb472f = self.zombieaisettings.var_e58a65b7a8f5973c.var_137aadf13edb472f;
  self.var_2810bd3ceddee8da = spawnStruct();
  self.var_2810bd3ceddee8da.alivecount = 0;
  self.var_2810bd3ceddee8da.var_f0017ea1d841aa3b = var_137aadf13edb472f.var_f0017ea1d841aa3b;
  self.var_2810bd3ceddee8da.enabled = var_137aadf13edb472f.var_b32c46fa7a4dcfd7;
  self.var_2810bd3ceddee8da.var_9ee6d8bf092e9f5f = var_137aadf13edb472f.var_9ee6d8bf092e9f5f;
  self.var_2810bd3ceddee8da.var_a8b1e7ba44c6b434 = var_137aadf13edb472f.var_a8b1e7ba44c6b434;
  self.var_2810bd3ceddee8da.var_8ccab14ac67a50a4 = var_137aadf13edb472f.var_8ccab14ac67a50a4;
  self.var_2810bd3ceddee8da.var_e24f26f02c602117 = var_137aadf13edb472f.var_e24f26f02c602117;
  self.var_2810bd3ceddee8da.var_325ca50204f9d5e6 = var_137aadf13edb472f.var_325ca50204f9d5e6;
  self.var_2810bd3ceddee8da.var_511c2cd6c3d6e420 = var_137aadf13edb472f.var_511c2cd6c3d6e420;
  self.var_2810bd3ceddee8da.var_847dfca7cc99d08c = var_137aadf13edb472f.var_847dfca7cc99d08c;
  self.var_2810bd3ceddee8da.orbdamage = var_137aadf13edb472f.orbdamage;
  self.var_2810bd3ceddee8da.var_9a854c78447931a6 = var_137aadf13edb472f.var_9a854c78447931a6;
  self.var_2810bd3ceddee8da.spawnlocations = [];
  self.var_2810bd3ceddee8da.ents = [];
  var_de7821bc51ab43a0 = level.players;

  for(i = 0; i < self.var_2810bd3ceddee8da.var_9ee6d8bf092e9f5f; i++) {
    self.var_2810bd3ceddee8da.ents[i] = spawn("script_model", self.origin);
    self.var_2810bd3ceddee8da.ents[i] setModel(self.var_2810bd3ceddee8da.var_f0017ea1d841aa3b);
    self.var_2810bd3ceddee8da.ents[i].var_52dcdba485e7ceeb = "tag_origin";
    self.var_2810bd3ceddee8da.ents[i].parent = self;
    namespace_4e684dc307dd4bdd::function_a8c2757799695a5a(self.var_2810bd3ceddee8da.ents[i]);

    if(var_de7821bc51ab43a0.size < 7) {
      namespace_4e684dc307dd4bdd::function_79bb217b25d90ffd(self.var_2810bd3ceddee8da.ents[i], 80, 12, 150);
      continue;
    }

    namespace_4e684dc307dd4bdd::function_79bb217b25d90ffd(self.var_2810bd3ceddee8da.ents[i], 100, 24, 200);
  }

  self notify("orb_attack_setup_complete");
}

function private function_a872fb483eb16ecd() {
  level endon("game_ended");
  self endon("death");
  self endon("fake_death");

  while(true) {
    self waittill("teleport_dissolve_start");
    currentstate = asm_getcurrentstatename(self.asmname);
    duration = function_efc9be9e46d1f242(self.asmname, currentstate, "teleport_dissolve_start", "teleport_dissolve_end");

    if(!isDefined(duration)) {
      utility::function_3ab9164ef76940fd("reactive_miscellaneous", "off");
      continue;
    }

    var_84b4dd2d6d918790 = duration * 0.001;
    var_84b4dd2d6d918790 = ceil(var_84b4dd2d6d918790);
    var_84b4dd2d6d918790 = clamp(var_84b4dd2d6d918790, 0, 5);
    utility::function_3ab9164ef76940fd("reactive_miscellaneous", "dissolve" + var_84b4dd2d6d918790);
    timeouttime = 10;
    returnstr = waittill_notify_or_timeout_return("teleport_reappear_start", timeouttime);

    if(isDefined(returnstr) && returnstr == "timeout") {
      utility::function_3ab9164ef76940fd("reactive_miscellaneous", "off");
      continue;
    }

    currentstate = asm_getcurrentstatename(self.asmname);
    duration = function_efc9be9e46d1f242(self.asmname, currentstate, "teleport_reappear_start", "teleport_reappear_end");

    if(!isDefined(duration)) {
      utility::function_3ab9164ef76940fd("reactive_miscellaneous", "off");
      continue;
    }

    var_84b4dd2d6d918790 = duration * 0.001;
    var_84b4dd2d6d918790 = ceil(var_84b4dd2d6d918790);
    var_84b4dd2d6d918790 = clamp(var_84b4dd2d6d918790, 0, 5);
    utility::function_3ab9164ef76940fd("reactive_miscellaneous", "reappear" + var_84b4dd2d6d918790);
    waittill_notify_or_timeout("teleport_reappear_end", var_84b4dd2d6d918790);
    utility::function_3ab9164ef76940fd("reactive_miscellaneous", "off");
  }
}

function function_a49fd15fdc5e36d() {
  var_d03362e45f7b37e4 = self.zombieaisettings.var_e58a65b7a8f5973c.var_d03362e45f7b37e4;
  self.var_31a8be167672493a = spawnStruct();
  self.var_31a8be167672493a.var_e69261597a83bfc0 = var_d03362e45f7b37e4.var_e69261597a83bfc0;
  self.var_31a8be167672493a.var_1407b1c49c260053 = var_d03362e45f7b37e4.var_1407b1c49c260053;
  self.var_31a8be167672493a.var_3c0930bfc4705ac3 = var_d03362e45f7b37e4.var_3c0930bfc4705ac3;
}

function function_da113f51de4d2e90(asmname, statename, params) {}

function function_ba184fc219b5f1ed(asmname, statename, params) {
  self.entitydata.var_4195498e9121e409 = 0;
}

function private function_fe2a0d688b86f777(settings, phaseindex) {
  self.var_898e7a18e3c1354c.phase[phaseindex] = spawnStruct();
  self.var_898e7a18e3c1354c.phase[phaseindex].benabled = settings.enabled;
  self.var_898e7a18e3c1354c.phase[phaseindex].var_a09d213a675c2bab = settings.var_a09d213a675c2bab;
  self.var_898e7a18e3c1354c.phase[phaseindex].var_3388296f048ada35 = settings.var_60480d8fa1d4809d;
  self.var_898e7a18e3c1354c.phase[phaseindex].var_4db08ad08b477cfd = settings.var_4db08ad08b477cfd / 100;
}

function function_5fef44b6310a75b9() {
  self.var_898e7a18e3c1354c = spawnStruct();
  self.var_898e7a18e3c1354c.phase = [];
  self.var_898e7a18e3c1354c.var_4e598e1797c70ad1 = 0;
  var_e90fa9172db4145 = self.zombieaisettings.var_e58a65b7a8f5973c.var_f4729d0569e460b8.var_d8dc882da4891850;
  function_fe2a0d688b86f777(var_e90fa9172db4145, 0);
  var_d353b5cd8fecf9eb = self.zombieaisettings.var_e58a65b7a8f5973c.var_3c9964059ea30c5e.var_d8dc882da4891850;
  function_fe2a0d688b86f777(var_d353b5cd8fecf9eb, 1);
  var_257ff921d827df07 = self.zombieaisettings.var_e58a65b7a8f5973c.var_5a24dc6495846e22.var_d8dc882da4891850;
  function_fe2a0d688b86f777(var_257ff921d827df07, 2);
}

function private function_371b90eded88e54d(asmname, statename, startnotetrack, endnotetrack, scale, reverse) {
  tempanim = self asmgetanim(asmname, statename);
  assert(isDefined(tempanim));
  xanim = asm_getxanim(statename, tempanim);

  if(animhasnotetrack(xanim, startnotetrack)) {
    assert(animhasnotetrack(xanim, endnotetrack));
    startnote = getnotetracktimes(xanim, startnotetrack);
    endnote = getnotetracktimes(xanim, endnotetrack);

    if(startnote[0] > 0) {
      asm_donotetracks(asmname, statename, &function_cc1e700beab88ed0, undefined, undefined, 0);
    }

    animlength = getanimlength(xanim);
    warpstarttime = startnote[0];

    if(warpstarttime > 0) {
      warpstarttime = startnote[0] * animlength * 1000;
      warpstarttime -= mod(int(warpstarttime), level.frameduration);
      warpstarttime = warpstarttime / animlength / 1000;
    }

    end_time = endnote[0];
    duration = int((end_time - warpstarttime) * animlength * 1000);
    duration += level.frameduration - mod(duration, level.frameduration);
    movedelta = getmovedelta(xanim, startnote[0], endnote[0]);
    angledelta = getangledelta3d(xanim, startnote[0], endnote[0]);

    if(!isDefined(scale)) {
      scale = 1;
    }

    if(istrue(reverse)) {
      movedelta = -1 * movedelta;
    }

    targetpos = self.origin + scale * movedelta;

    sphere(targetpos, 100, (1, 0, 0), undefined, 50);

    targetangles = combineangles(self.angles, angledelta);
    motionwarpwithtimes(xanim, targetpos, targetangles, warpstarttime, 1, duration, 0);
  }
}

function private function_cc1e700beab88ed0(note) {
  if(note == "warp_forward_start") {
    return 1;
  }
}

function private function_abfa121f5203d2c2() {
  if(!isDefined(self.entitydata.phase)) {
    return "phase1";
  }

  return self.entitydata.phase;
}

function private function_8241cc7dd8266f69() {
  switch (self.entitydata.var_4195498e9121e409) {
    case 2:
      return "med";
    case 3:
      return "heavy";
    default:
      return "light";
  }
}

function function_2e560a9030f7c915(asmname, statename, tostatename, params) {
  assert(isDefined(self.entitydata) && isDefined(self.entitydata.entitystate));

  if(self.entitydata.entitystate != 0) {
    return true;
  }

  return false;
}

function function_7cd7a5fa2e0d8e24(asmname, statename) {
  if(self asmhasstate(asmname, statename)) {
    tempanim = asm_lookupanimfromalias(statename, string(function_abfa121f5203d2c2()));

    if(isDefined(tempanim)) {
      xanim = asm_getxanim(statename, tempanim);
      movedelta = getmovedelta(xanim);

      if(isDefined(movedelta)) {
        return movedelta;
      }
    }
  }

  return undefined;
}

function function_5d24e07aabf2b47b(asmname, statename, params) {
  return asm_lookupanimfromalias(statename, string(function_abfa121f5203d2c2()));
}

function function_fcb47bfcb1f1f390(asmname, statename, params) {
  return asm_lookupanimfromalias(statename, string(function_abfa121f5203d2c2() + "-" + function_8241cc7dd8266f69()));
}

function function_57f69072cb4d170f(asmname, statename, params) {
  animid = self asmgetanim(self.asmname, "death");
  assert(isDefined(animid));
  xanim = asm_getxanim("death", animid);
  self.deathanimduration = int(getanimlength(xanim) * 1000);
  asm_playanimstate(asmname, statename, params);
}