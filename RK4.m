function h_final = RK4(h0, dt, t_max, r, g, R)
  n_steps = floor(t_max / dt);
  h = h0;

  for step = 1:n_steps
    k1 = -(r^2 * sqrt(2 * g * h)) / (2 * h * R - h^2);
    k2 = -(r^2 * sqrt(2 * g * (h + 0.5 * dt * k1))) / (2 * (h + 0.5 * dt * k1) * R - (h + 0.5 * dt * k1)^2);
    k3 = -(r^2 * sqrt(2 * g * (h + 0.5 * dt * k2))) / (2 * (h + 0.5 * dt * k2) * R - (h + 0.5 * dt * k2)^2);
    k4 = -(r^2 * sqrt(2 * g * (h + dt * k3))) / (2 * (h + dt * k3) * R - (h + dt * k3)^2);

    h = h + (dt / 6) * (k1 + 2 * k2 + 2 * k3 + k4);

    if h < 0
      h = 0;  % El agua no puede ser negativa
      break;
    end
  end

  h_final = h;
end

