# add std cells .db files
set DB_STDCELLS {uk65lscllmvbbr_120c25_tc.db}

set search_path [list $search_path . ../include /home/alessandra.dolmeta/HORCRUX/CHIMERA/scripts/synthesis/lib /eda/synopsys/2021-22/RHELx86/SYN 2021.06-SP4/libraries/syn /software/dk/umc65/Core-lib_LL_Multi-Voltage_Reg.Vt/synopsys /software/dk/umc65/memories_LL/SHKA65_8192X32X1CM16 /software/dk/umc65/memories_LL/SHKA65_256X20X1CM4 \
                        /"$(CHANGE_PATH)"/scripts/synthesis/lib ]
set link_library [list "*" "uk65lscllmvbbr_120c25_tc.db" "dw_foundation.sldb" ]

# target library
set target_library [list "uk65lscllmvbbr_120c25_tc.db" "SHKA65_8192X32X1CM16_tt1p2v25c.db" "SHKA65_256X20X1CM4_tt1p2v25c.db"]
set synthetic_library [list "dw_foundation.sldb" ]


# link library
set link_library "* $target_library"

#debug output info
puts "------------------------------------------------------------------"
puts "USED LIBRARIES"
puts $link_library
puts "------------------------------------------------------------------"

set link_library " * $link_library"
