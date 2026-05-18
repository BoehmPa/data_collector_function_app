import logging
import azure.functions as func

from data_collector import init_db, collect_once

app = func.FunctionApp()


@app.timer_trigger(
    schedule="0 0 */6 * * *",
    arg_name="timer",
    run_on_startup=True,
    use_monitor=True,
)
def weather_collector(timer: func.TimerRequest) -> None:
    logging.info("Weather collector function started.")

    if timer.past_due:
        logging.warning("Timer is past due.")

    init_db()
    collect_once()

    logging.info("Weather collector function finished.")