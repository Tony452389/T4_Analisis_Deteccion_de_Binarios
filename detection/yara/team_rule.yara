rule team_rule
{
    meta:
        descripcion = "Detecta el malware escolar por string unica"
        autor = "Sergio Pedro Sepúlveda Rodríguez"
        fecha = "2026-05-07"
    strings:
        $s1 = "Debugger detected!" ascii nocase
        $s2 = "disable_firewall" ascii nocase
        $s3 = "connect_to_server" ascii nocase
        $s4 = "upload_data" ascii nocase
        $s5 = "admin_login=true" ascii nocase
        $s6 = "calc.exe" ascii nocase
        $va = "VirtualAlloc" ascii wide
        $we = "WinExec" ascii wide
        $rtl = "RtlMoveMemory" ascii wide
        $rwx = { 40 00 00 00 }
    condition:
    3 of ($s*) or
    uint16(0) == 0x5A4D or
    all of ($va, $we, $rtl) or
    $rwx
}
