/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\battletracks.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace battletracks;

function private autoexec __init__system__() {
  system::register(#"battletracks", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("vehicle", "battletrack_active", 1, 1, "int");
}

function private event_handler[enter_vehicle] function_860f46d6(eventstruct) {
  if(isPlayer(self)) {
    vehicle = self getvehicleoccupied();

    if(eventstruct.seat_index == 0 || isDefined(vehicle.var_260e3593) && vehicle.var_260e3593 == eventstruct.seat_index) {
      vehicle function_fe45d0ae();
      self function_afb0648d(vehicle);
    }
  }
}

function private event_handler[exit_vehicle] function_c8e0f88d(eventstruct) {
  if(isPlayer(self)) {
    if(eventstruct.seat_index == 0 || isDefined(eventstruct.vehicle.var_260e3593) && eventstruct.vehicle.var_260e3593 == eventstruct.seat_index) {
      eventstruct.vehicle function_982d5b1();
    }
  }
}

function private event_handler[change_seat] function_63d4043f(eventstruct) {
  if(isPlayer(self)) {
    if(eventstruct.seat_index == 0 || isDefined(eventstruct.vehicle.var_260e3593) && eventstruct.vehicle.var_260e3593 == eventstruct.seat_index) {
      if(!(eventstruct.old_seat_index == 0 || isDefined(eventstruct.vehicle.var_260e3593) && eventstruct.vehicle.var_260e3593 == eventstruct.old_seat_index)) {
        eventstruct.vehicle function_fe45d0ae();
        self function_afb0648d(eventstruct.vehicle);
      }

      return;
    }

    if(eventstruct.old_seat_index == 0 || isDefined(eventstruct.vehicle.var_260e3593) && eventstruct.vehicle.var_260e3593 == eventstruct.old_seat_index) {
      if(!(eventstruct.seat_index == 0 || isDefined(eventstruct.vehicle.var_260e3593) && eventstruct.vehicle.var_260e3593 == eventstruct.seat_index)) {
        eventstruct.vehicle function_982d5b1();
      }
    }
  }
}

function private event_handler[vehicle_killed] function_c5f9a554(eventstruct) {
  self function_fe45d0ae();
}

function private event_handler[event_35559816] function_35559816(eventstruct) {
  if(isvehicle(eventstruct.vehicle)) {
    if(isDefined(eventstruct.vehicle.battletrack_active)) {
      eventstruct.vehicle function_fe45d0ae();
      return;
    }

    self function_afb0648d(eventstruct.vehicle);
  }
}

function private event_handler[event_29e6e4b2] function_29e6e4b2(eventstruct) {
  if(isvehicle(eventstruct.vehicle)) {
    self function_afb0648d(eventstruct.vehicle);
  }
}

function private function_982d5b1() {
  if(!sessionmodeiscampaigngame()) {
    self endon(#"death");
    self endon(#"hash_10f5e7a492971517");
    wait getdvarint(#"hash_69d64509de665052", 5);

    if(isDefined(self.battletrack_active)) {
      self clientfield::set("battletrack_active", 0);
      self stopsound(self.battletrack_active);
      self.battletrack_active = undefined;
    }
  }
}

function function_fe45d0ae() {
  if(!sessionmodeiscampaigngame()) {
    self notify(#"hash_10f5e7a492971517");

    if(isDefined(self.battletrack_active)) {
      self clientfield::set("battletrack_active", 0);
      self stopsound(self.battletrack_active);
      self.battletrack_active = undefined;
    }
  }
}

function private function_afb0648d(vehicle) {
  if(!sessionmodeiscampaigngame()) {
    if(self isinvehicle()) {
      vehicle function_fe45d0ae();
      vehicle.battletrack_active = undefined;

      if(isDefined(vehicle.vehicleassembly)) {
        var_e273c985 = self function_18df0fba(vehicle.vehicleassembly);
        var_45750595 = getscriptbundle(var_e273c985);

        if(isDefined(var_45750595)) {
          if(!isDefined(self.var_7b87b98c)) {
            self.var_7b87b98c = 0;
          } else {
            self.var_7b87b98c = (self.var_7b87b98c + 1) % var_45750595.var_50c23eb3.size;
          }

          track_name = var_45750595.var_50c23eb3[self.var_7b87b98c].track;

          if(isDefined(track_name)) {
            var_3ee3065f = getscriptbundle(track_name);

            if(isDefined(var_3ee3065f) && isDefined(var_3ee3065f.var_921a9ffa)) {
              vehicle.battletrack_active = var_3ee3065f.var_921a9ffa;
              vehicle playsoundwithnotify(vehicle.battletrack_active, "battletrack_complete");
              vehicle clientfield::set("battletrack_active", 1);
            }
          }
        }
      }
    }
  }
}