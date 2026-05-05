rule team_rule
{
    meta:
        descripcion = "Detecta el malware escolar por strings detectados"
        autor = "Sergio Pedro Sepúlveda Rodríguez"
        fecha = "2026-05-05"

    strings:
        $s1 = "Debugger detected!" ascii nocase
        $s2 = "disable_firewall" ascii nocase
        $s3 = "connect_to_server" ascii nocase
        $s4 = "upload_data" ascii nocase
        $s5 = "admin_login=true" ascii nocase
        $s6 = "calc.exe" ascii nocase

    condition:
        3 of ($s*)
}
