/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_slider.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_utility;
#namespace zm_perk_slider;

function private autoexec __init__system__() {
  system::register(#"zm_perk_slider", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!is_true(getgametypesetting(#"hash_4b8929fb898a9e80"))) {
    return;
  }

  enable_slider_perk_for_level();
}

function enable_slider_perk_for_level() {
  zm_perks::register_perk_clientfields(#"talent_phdslider", &function_4bb29d61, &function_90b5e96c);
  zm_perks::register_perk_effects(#"talent_phdslider", "slider_light");
  zm_perks::register_perk_init_thread(#"talent_phdslider", &init_slider);
}

function init_slider() {}

function function_4bb29d61() {
  clientfield::register("toplayer", "slide_fx", 17000, 1, "int", &slide_fx, 0, 0);

  if(zm_utility::is_classic()) {
    clientfield::register("scriptmover", "phd_slider_machine_rob_poweron", 17000, 1, "int", &phd_slider_machine_rob_poweron, 0, 0);
    clientfield::register("scriptmover", "phd_slider_machine_rob_purchase", 17000, 1, "counter", &phd_slider_machine_rob_purchase, 0, 0);
  }
}

function function_90b5e96c() {}

function slide_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(isPlayer(self) && self hasdobj(fieldname)) {
    if(bwastimejump) {
      self.var_b4099c13 = function_239993de(fieldname, #"hash_129046e1c36bd447", self, "j_ankle_ri");
      return;
    }

    if(isDefined(self.var_b4099c13)) {
      stopfx(fieldname, self.var_b4099c13);
    }
  }
}

function phd_slider_machine_rob_purchase(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level endon(#"end_game");
  self endon(#"death");
  self notify("3d4720573ae624b0");
  self endon("3d4720573ae624b0");

  if(bwastimejump) {
    self function_f6e99a8d("rob_phd_slide_side_lights");
    self function_f6e99a8d("rob_phd_slide_top_lights1");
    self function_f6e99a8d("rob_phd_slide_top_lights2");
    wait 1;
    self playrenderoverridebundle("rob_phd_slide_side_lights");
    self playrenderoverridebundle("rob_phd_slide_top_lights1");
    self playrenderoverridebundle("rob_phd_slide_top_lights2");
  }
}

function phd_slider_machine_rob_poweron(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self playrenderoverridebundle("rob_phd_slide_side_lights");
    self playrenderoverridebundle("rob_phd_slide_top_lights1");
    self playrenderoverridebundle("rob_phd_slide_top_lights2");
  }
}