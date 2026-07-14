/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_4880fce3c83f33ef.gsc
*****************************************************/

#using scripts\common\vehicle;
#namespace namespace_258c393149f2e837;

function autoexec main() {}

function private init_radar_ping(data) {
  vehicle = self;

  if(data.enabled) {
    assert(isDefined(vehicle.mtx));
    vehicle.mtx.radarping = spawnStruct();
    vehicle.mtx.radarping.sweepradius = data.radarpingsweepradius;
    vehicle.mtx.radarping.sweeptime = data.radarpingsweeptime;
    vehicle.mtx.radarping.sweeptimedelay = data.var_2962c1bc94835e40;
    vehicle.mtx.radarping.driveronly = data.var_28c00f2a5b9ec6e5;

    if(isDefined(vehicle.occupants)) {
      foreach(occupant in vehicle.occupants) {
        start_radar_ping(vehicle, occupant);
      }
    }

    return;
  }

  vehicle.mtx.radarping = undefined;
}

function private start_radar_ping(vehicle, player) {
  if(isDefined(vehicle.mtx.radarping) && !player.var_64cf52105a48848b) {
    data = vehicle.mtx.radarping;
    sweeptime = int(data.sweeptime * 1000);
    sweepdelay = int(data.sweeptimedelay * 1000);
    player.var_64cf52105a48848b = 1;
  }
}

function private stop_radar_ping(vehicle, player) {
  if(isDefined(vehicle.mtx.radarping) && player.var_64cf52105a48848b) {
    player.var_64cf52105a48848b = undefined;
  }
}

function on_enter_vehicle(vehicle, player) {
  start_radar_ping(vehicle, player);
}

function on_exit_vehicle(vehicle, player) {
  stop_radar_ping(vehicle, player);
}

function function_c65ed663d13b2579(bundlename) {
  vehicle = self;

  if(!isDefined(bundlename)) {
    bundlename = vehicle function_8722cd990f035753();

    if(!isDefined(bundlename)) {
      return;
    }
  }

  assert(isxhashasset(bundlename));
  data = getscriptbundlefieldvalues(bundlename, [#"radarping"]);

  if(isDefined(data)) {
    if(isDefined(data.radarping)) {
      vehicle init_radar_ping(data.radarping);
    }
  }
}

function function_6f973aa5086dcf35() {
  vehicle = self;
  bundlename = vehicle function_8722cd990f035753();

  if(!isDefined(bundlename)) {
    vehicle.var_429d5e520209434f = undefined;
    return;
  }

  assert(isxhashasset(bundlename));
  bundledata = getscriptbundlefieldvalues(bundlename, [#"collision"]);
  vehicle.var_429d5e520209434f = bundledata.collision;
  vehicle update_max_health();
}

function private function_615b562c48bb83f8(newmaxhealth) {
  if(newmaxhealth == self.maxhealth) {
    return;
  }

  currenthealthpercentage = self.health / self.maxhealth;
  self.maxhealth = newmaxhealth;
  self.health = int(ceil(currenthealthpercentage * self.maxhealth));
}

function private update_max_health() {
  var_e2135a579d15e713 = self.var_429d5e520209434f;
  newmaxhealth = var_e2135a579d15e713.maxhealth;

  if(newmaxhealth && newmaxhealth != 0) {
    function_615b562c48bb83f8(newmaxhealth);
    return;
  }

  if(!isDefined(var_e2135a579d15e713)) {
    bundledata = undefined;
    ref = vehicle::get_ref();

    if(vehicle::has_data(ref)) {
      bundledata = vehicle::get_data(ref);
    }

    if(bundledata.damage.health && self.maxhealth != bundledata.damage.health) {
      function_615b562c48bb83f8(bundledata.damage.health);
    }

    return;
  }

  assert(newmaxhealth == 0);
}