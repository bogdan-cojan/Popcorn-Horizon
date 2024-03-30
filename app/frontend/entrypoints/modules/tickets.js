export default{
  namespaced: true,
  state: {
    list: [],
  },
  mutations: {
    addTicket(state, ticket) {
      state.list.push(ticket);
    },
  },
  actions: {
    async create({ commit }, payload) {
      const res = await fetch("/apis/v1/tickets", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ ticket: payload })
      });

      if(res.status === 201) {
        alert("Yuhuu!Tickets created successfully!");
      }
    },
  },
}