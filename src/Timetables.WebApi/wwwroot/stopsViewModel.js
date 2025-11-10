
function stopsViewModel() {
  return {
    route: '',
    subroutes: [],

    async getStops() {
      const { route, subroutes } = await stopsDataService.getStopsForRoute(1);
      
      this.route = route;
      this.subroutes = subroutes.map(sr => ({
        ...sr,
        selectedStopNum: '',
        selectedStop: null,
        loading: false
      }));
    },

    async getNextBusInfo(subroute) {      
      subroute.loading = true;
      
      const nextTime = await stopsDataService.getNextBusTimeForStop(subroute.selectedStopNum);

      subroute.selectedStop = {
        nextBusInfo: nextTime
      };
      
      subroute.loading = false;
    }
  };
}