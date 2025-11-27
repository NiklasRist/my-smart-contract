import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("MessageBoardModule", (m) => {
  const board = m.contract("MessageBoard");
  return { board };
});
