import logging
import azure.functions as func
from collector import collect_once

app = func.FunctionApp()

@app.timer_trigger(
    schedule="0 */5 * * * *",
    arg_name="timer",
    run_on_startup=True,
    use_monitor=True
)
def weather_collector(timer: func.TimerRequest) -> None:
    logging.info("Weather collector started.")
    collect_once()