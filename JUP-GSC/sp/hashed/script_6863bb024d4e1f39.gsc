/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_6863bb024d4e1f39.gsc
*************************************************/

#using scripts\asm\asm;
#using scripts\asm\cap;
#using scripts\asm\shared\utility;
#namespace cap_green_beam;

function function_b3363cc14cbca5f3(asmname, statename, params) {
  laser = spawn("script_model", self gettagorigin("tag_accessory_left"));
  laser.angles = self gettagangles("tag_accessory_left");
  laser setModel("misc_wm_handheld_green_laser");
  laser linkTo(self, "tag_accessory_left");
  self.laser = laser;

  if(!isDefined(self.green_beam)) {
    self.green_beam = 1;
  }
}

function function_13989fec47c1786f(asmname, statename, params) {
  if(istrue(self.green_beam)) {
    return false;
  }

  return true;
}

function function_eb6dc231debf349c(note) {
  if(!isai(self)) {
    return;
  }

  if(note == "greenbeam_on") {
    if(isDefined(self.var_4f088434309b2333)) {
      self.laser setmoverlaserweapon(self.var_4f088434309b2333);
    } else {
      self.laser setmoverlaserweapon("iw8_laser_painter_ac130_lasso_short");
    }

    if(istrue(self.no_laser)) {
      return;
    }

    self.laser laserforceon();
    return;
  }

  if(note == "greenbeam_off" && isDefined(self.laser)) {
    self.laser laserforceoff();
  }
}

function function_3029fafe943a11b9(asmname, statename, params) {
  if(isDefined(self.laser)) {
    self.laser delete();
    self.laser = undefined;
  }

  self.green_beam = 0;
  scripts\asm\cap::cap_exit(asmname, statename, params);
}