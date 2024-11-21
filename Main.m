function Main()
  % Parámetros del problema
  g = 9.81;  % m/s^2 (gravedad)
  R = 4.0;   % m (radio del tanque)
  r = 0.02;  % m (radio del orificio)
  h0 = 6.5;  % m (altura inicial del agua)
  t_max = 10 * 60;  % 10 minutos en segundos
  variacionesDeTiempo = [10, 5, 1];

  % Matriz para guardar resultados
  resultados_Euler = zeros(1, length(variacionesDeTiempo));
  resultados_RK4 = zeros(1, length(variacionesDeTiempo));

  % Simulaciones para Euler y RK4
  for i = 1:length(variacionesDeTiempo)
    dt = variacionesDeTiempo(i);
    resultados_Euler(i) = Euler(h0, dt, t_max, r, g, R);
    resultados_RK4(i) = RK4(h0, dt, t_max, r, g, R);
  end

  % Mostrar resultados
  fprintf('Resultados (Euler):\n');
  disp(resultados_Euler);
  fprintf('Resultados (RK4):\n');
  disp(resultados_RK4);

  % Calcular y mostrar convergencia
  fprintf('Convergencia (Euler):\n');
  CalcularConvergencia(resultados_Euler, variacionesDeTiempo);
  fprintf('Convergencia (RK4):\n');
  CalcularConvergencia(resultados_RK4, variacionesDeTiempo);
end

