DECLARE
    CURSOR cursor_medicos IS
    SELECT
        med_run,
        dv_run,
        initcap(pnombre
                || ' '
                || apaterno) AS nombre_completo,
        sueldo_base,
        100000,
        sueldo_base + 100000
    FROM
        medico
    WHERE
        sueldo_base < 1000000
    order by sueldo_base asc;

    v_mes_proceso    NUMBER(2) := extract(MONTH FROM sysdate)-1;
    v_anno_proceso   NUMBER(4) := extract(YEAR FROM sysdate);
BEGIN
    FOR registro_medicos IN cursor_medicos LOOP
        dbms_output.put_line('MES PROCESO: ' || v_mes_proceso);
        dbms_output.put_line('AÑO PROCESO: ' || v_anno_proceso);
        dbms_output.put_line('RUN MEDICO: ' || registro_medicos.med_run  || registro_medicos.dv_run);
        dbms_output.put_line('NOMBRE COMPLETO: ' || registro_medicos.nombre_completo);
        dbms_output.put_line('SUELDO BASE: ' || registro_medicos.sueldo_base);
        dbms_output.put_line('AGUINALDO: ' || 100000);
        dbms_output.put_line('SUELDO FINAL: ' ||(registro_medicos.sueldo_base + 100000));
        dbms_output.put_line('  ');
        INSERT INTO info_medico (
            mes_proceso,
            anno_proceso,
            numrun_medico,
            nombre_completo,
            sueldo_base,
            aguinaldo,
            sueldo_final
        ) VALUES (
            v_mes_proceso,
            v_anno_proceso,
            registro_medicos.med_run  || registro_medicos.dv_run,
            registro_medicos.nombre_completo,
            registro_medicos.sueldo_base,
            100000,
            registro_medicos.sueldo_base + 100000
        );

    END LOOP;
END;