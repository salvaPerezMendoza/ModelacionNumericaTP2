function AnalisisSensibilidad1()

    % Parámetros del problema
    g = 9.81;  % m/s^2 (gravedad)
    R = 4.0;   % m (radio del tanque)
    r = 0.02;  % m (radio del orificio)
    h0 = 6.5;  % m (altura inicial del agua)
    t_max = 10 * 60;  % 10 minutos en segundos
    variacionesDeTiempo = [10, 5, 1];  % Diferentes pasos de tiempo
    c_c_M1 = 1.0;  % Modelo M1: Sin contracción
    c_c_M2 = 0.6;  % Modelo M2: Con contracción

    % Matrices para resultados
    resultados_M1 = zeros(1, length(variacionesDeTiempo));
    resultados_M2 = zeros(1, length(variacionesDeTiempo));

    % Método RK4 generalizado
    function h_final = RK4(h0, dt, t_max, r, g, R, c_c)
        n_steps = floor(t_max / dt);
        h = h0;

        for step = 1:n_steps
            k1 = -(r^2 * c_c * sqrt(2 * g * h)) / (2 * h * R - h^2);
            k2 = -(r^2 * c_c * sqrt(2 * g * (h + 0.5 * dt * k1))) / (2 * (h + 0.5 * dt * k1) * R - (h + 0.5 * dt * k1)^2);
            k3 = -(r^2 * c_c * sqrt(2 * g * (h + 0.5 * dt * k2))) / (2 * (h + 0.5 * dt * k2) * R - (h + 0.5 * dt * k2)^2);
            k4 = -(r^2 * c_c * sqrt(2 * g * (h + dt * k3))) / (2 * (h + dt * k3) * R - (h + dt * k3)^2);

            h = h + (dt / 6) * (k1 + 2 * k2 + 2 * k3 + k4);

            if h < 0
                h = 0;  % El agua no puede ser negativa
                break;
            end
        end
        h_final = h;
    end

    % Simulaciones para ambos modelos
    for i = 1:length(variacionesDeTiempo)
        dt = variacionesDeTiempo(i);
        resultados_M1(i) = RK4(h0, dt, t_max, r, g, R, c_c_M1);  % Modelo M1
        resultados_M2(i) = RK4(h0, dt, t_max, r, g, R, c_c_M2);  % Modelo M2
    end

    % Mostrar resultados
    fprintf('Resultados Modelo M1 (RK4):\n');
    disp(resultados_M1);
    fprintf('Resultados Modelo M2 (RK4):\n');
    disp(resultados_M2);

    % Comparar resultados
    fprintf('Diferencias entre Modelo M1 y Modelo M2:\n');
    diferencias = abs(resultados_M1 - resultados_M2);
    for i = 1:length(variacionesDeTiempo)
        fprintf('Δt = %d s -> Diferencia: %.10f m\n', variacionesDeTiempo(i), diferencias(i));
    end

end

