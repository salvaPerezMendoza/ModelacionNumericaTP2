function [] = Euler()

% Parámetros del problema
g = 9.81;  % m/s^2 (gravedad)
R = 4.0;   % m (radio del tanque)
r = 0.02;  % m (radio del orificio)
h0 = 6.5;  % m (altura inicial del agua)

%modelo M1
function dh = dh_dt(h, r, g, R)
    dh = -(r^2 * sqrt(2 * g * h)) / (2 * h * R - h^2);
end

% Método de Euler
function h_final = euler_simple(h0, dt, cantDeMinutos, r, g, R)
  h = h0;
  t = 0;
  while t < cantDeMinutos
    h = h + dt * dh_dt(h, r, g, R);
    t = t + dt;
  end
  h_final = h;
end

cantDeMinutos = 10 * 60;  % Cant de Minutos
variacionesDeTiempo = [10, 5, 1];
resultados = [0,0,0];

% Calcular el nivel de agua para cada Δt
disp('Resultados del nivel de agua después de 10 minutos:');

for i=1:3
  dt = variacionesDeTiempo(i);
  h_final = euler_simple(h0, dt, cantDeMinutos, r, g, R);
  resultados(i) = h_final;
  fprintf('Δt = %d s: Altura final = %.10f m\n', dt, h_final);

end

  % Calcular errores entre las simulaciones
error_T10 = abs(resultados(1) - resultados(3));  % Diferencia entre Δt=10 y Δt=1
error_T5 = abs(resultados(2) - resultados(3));   % Diferencia entre Δt=5 y Δt=1

% Mostrar resultados de los errores y convergencia
fprintf('\nEl resultado más preciso es %.35f m (Δt = 1 s)\n', resultados(3));
fprintf('\n y los otros resultados son %.35f %.35f m (Δt = 1 s)\n', resultados(1), resultados(2));
fprintf('Variación entre Δt=10 s y Δt=1 s: %.35f m\n', error_T10);
fprintf('Variación entre Δt=5 s y Δt=1 s: %.35f m\n', error_T5);

if error_T5 > 0
  errorDeConvergencia = error_T10 / error_T5;  % Razón de convergencia
  fprintf('Relación entre los errores (convergencia): %.25f\n', errorDeConvergencia);
else
  fprintf('No se puede calcular la relación de convergencia porque error_T5 es 0.\n');
end

end
