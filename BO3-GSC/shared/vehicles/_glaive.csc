/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\vehicles\_glaive.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\filter_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#namespace glaive;

function autoexec main() {
  clientfield::register("vehicle", "glaive_blood_fx", 1, 1, "int", & glaivebloodfxhandler, 0, 0);
}

function private glaivebloodfxhandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(isDefined(self.bloodfxhandle)) {
    stopfx(localclientnum, self.bloodfxhandle);
    self.bloodfxhandle = undefined;
  }
  settings = struct::get_script_bundle("vehiclecustomsettings", "glaivesettings");
  if(isDefined(settings)) {
    if(newvalue) {
      self.bloodfxhandle = playFXOnTag(localclientnum, settings.weakspotfx, self, "j_spineupper");
    }
  }
}