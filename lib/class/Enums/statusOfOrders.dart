class StatusOfOrders 
{
  static const String statusOfOrderPendiente = "Pendiente";
  static const String statusOfOrderEnviado = "Enviado";
  static const String statusOfOrderTerminado = "Terminado";

  static String getStatus(String input) 
  {
    String estatusActual = "";

    switch (input) 
    {
      case statusOfOrderPendiente:
        estatusActual = statusOfOrderPendiente;
        break;

      case statusOfOrderEnviado:
        estatusActual = statusOfOrderEnviado;
        break;

      case statusOfOrderTerminado:
        estatusActual = statusOfOrderTerminado;
        break;
    }

    return estatusActual;
  }
}
