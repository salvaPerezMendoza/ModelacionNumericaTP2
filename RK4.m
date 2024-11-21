function [] = RK4()

% Parámetros del problema
g = 9.81;  % m/s^2 (gravedad)
R = 4.0;   % m (radio del tanque)
r = 0.02;  % m (radio del orificio)
h0 = 6.5;  % m (altura inicial del agua)

% Función de derivada para el modelo M1
function dh = dh_dt(h, r, g, R)
  if h > 0
    dh = -(r^2 * sqrt(2 * g * h)) / (2 * h * R - h^2);
  else
    dh = 0;  % Detener cuando el tanque está vacío
  end
end

% Método de Runge-Kutta de orden 4
function h_final = rk4_method_simple(h0, dt, t_max, r, g, R)
  n_steps = floor(t_max / dt);
  h = h0;

  for i = 1:n_steps
    k1 = dh_dt(h, r, g, R);
    k2 = dh_dt(h + 0.5 * dt * k1, r, g, R);
    k3 = dh_dt(h + 0.5 * dt * k2, r, g, R);
    k4 = dh_dt(h + dt * k3, r, g, R);

    h = h + (dt / 6) * (k1 + 2 * k2 + 2 * k3 + k4);

    if h < 0
      h = 0;  % El agua no puede ser negativa
      break;
    end
  end
  h_final = h;
end

t_max = 10 * 60;  % Tiempo total en segundos (10 minutos)
variacionesDeTiempo = [10, 5, 1];  % Diferentes pasos de tiempo


% Simulaciones
disp('Resultados para diferentes Δt (Runge-Kutta 4):');

  dt = variacionesDeTiempo(1);
  resultados1 = rk4_method_simple(h0, dt, t_max, r, g, R);
  fprintf('Δt = %d s -> Altura final = %.45f m\n', dt, resultados1);


  dt = variacionesDeTiempo(2);
  resultados2 = rk4_method_simple(h0, dt, t_max, r, g, R);
  fprintf('Δt = %d s -> Altura final = %.45f m\n', dt, resultados2);


  dt = variacionesDeTiempo(3);
  resultados3 = rk4_method_simple(h0, dt, t_max, r, g, R);
  fprintf('Δt = %d s -> Altura final = %.45f m\n', dt, resultados3);



% Calcular errores entre las simulaciones
error_T10 = abs(resultados1 - resultados3);  % Diferencia entre Δt=10 y Δt=1
error_T5 = abs(resultados2 - resultados3);   % Diferencia entre Δt=5 y Δt=1

% Mostrar resultados de los errores y convergencia
fprintf('\nEl resultado más preciso es %.35f m (Δt = 1 s)\n', resultados3);
fprintf('\n y los otros resultados son %.35f %.35f m (Δt = 1 s)\n', resultados1, resultados2);
fprintf('Variación entre Δt=10 s y Δt=1 s: %.35f m\n', error_T10);
fprintf('Variación entre Δt=5 s y Δt=1 s: %.35f m\n', error_T5);

if error_T5 > 0
  errorDeConvergencia = error_T10 / error_T5;  % Razón de convergencia
  fprintf('Relación entre los errores (convergencia): %.25f\n', errorDeConvergencia);
else
  fprintf('No se puede calcular la relación de convergencia porque error_T5 es 0.\n');
end

end

