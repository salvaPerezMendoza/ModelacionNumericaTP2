function h_final = Euler(h0, dt, t_max, r, g, R)
  n_steps = floor(t_max / dt);
  h = h0;

  for step = 1:n_steps
    dh = -(r^2 * sqrt(2 * g * h)) / (2 * h * R - h^2);
    if h > 0
      h = h + dt * dh;
    else
      h = 0;  % El agua no puede ser negativa
      break;
    end
  end

  h_final = h;
end

