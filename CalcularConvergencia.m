function CalcularConvergencia(resultados, variacionesDeTiempo)
  % Comparar errores con respecto al paso más fino
  h_fino = resultados(end);  % Resultado con Δt más pequeño
  errores = abs(resultados - h_fino);

  % Mostrar errores
  for i = 1:length(variacionesDeTiempo)
    fprintf('Δt = %d s -> Error: %.10f\n', variacionesDeTiempo(i), errores(i));
  end

  % Relación de convergencia
  if length(variacionesDeTiempo) >= 3
    error_grande = errores(1);  % Error para Δt más grande
    error_medio = errores(2);   % Error para Δt intermedio
    if error_medio > 0
      ratio = error_grande / error_medio;
      fprintf('Relación de convergencia: %.10f\n', ratio);
    else
      fprintf('No se puede calcular la relación de convergencia (error medio es 0).\n');
    end
  end
end

