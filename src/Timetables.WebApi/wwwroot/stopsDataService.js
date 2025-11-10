const routes = {
  STOPS_API: 'http://localhost:5076/api/v1/stops'
};

const stopsDataService = {

  async getStopsForRoute(routeId) {
    try {
      const stops = await axios.get(`${routes.STOPS_API}/for-route/${routeId}`);
      console.log("stops/for-route response:", stops.data);

      return stops.data;

    } catch (error) {

      console.error(`error getting stops for route: ${routeId}:`, error);

      return {
        route: `${routeId}`,
        areAvailable: false,
        message: "unable to retrieve stops for route",
        subroutes: []
      };
    }
  },

  async getNextBusTimeForStop(stopNum) {
    try {
      const nextTime = await axios.get(`${routes.STOPS_API}/${stopNum}/next-bus-time`);

      console.log("next-bus-time response:", nextTime.data);

      return nextTime.data;

    } catch (error) {
      console.error(`error getting next bus time for: ${stopNum}:`, error);

      return {
        isAvailable: false,
        message: "unable to retrieve next bus time",
        time: "error",
        date: "error",
        dayOfWeek: "error"
      };
    }
  }
};