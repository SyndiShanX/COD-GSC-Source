/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\table_shared.gsc
***********************************************/

#namespace table;

load(str_filename, str_table_start, b_convert_numbers = 1) {
  a_table = [];
  n_header_row = tablelookuprownum(str_filename, 0, str_table_start);
  assert(n_header_row > -1, "<dev string:x38>");
  a_headers = tablelookuprow(str_filename, n_header_row);
  n_row = n_header_row + 1;

  do {
    a_row = tablelookuprow(str_filename, n_row);

    if(isDefined(a_row) && a_row.size > 0) {
      index = strstrip(a_row[0]);

      if(index != "") {
        if(index == "table_end") {
          break;
        }

        if(b_convert_numbers) {
          index = str_to_num(index);
        }

        a_table[index] = [];

        for(val = 1; val < a_row.size; val++) {
          if(strstrip(a_headers[val]) != "" && strstrip(a_row[val]) != "") {
            value = a_row[val];

            if(b_convert_numbers) {
              value = str_to_num(value);
            }

            a_table[index][a_headers[val]] = value;
          }
        }
      }
    }

    n_row++;
  }
  while(isDefined(a_row) && a_row.size > 0);

  return a_table;
}

str_to_num(value) {
  if(strisint(value)) {
    value = int(value);
  } else if(strisfloat(value)) {
    value = float(value);
  }

  return value;
}